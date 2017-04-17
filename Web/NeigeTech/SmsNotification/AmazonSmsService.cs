using System;
using System.Collections.Generic;
using System.Text;
using Amazon.Runtime;
using Amazon.Runtime.CredentialManagement;
using Amazon.SimpleNotificationService;
using Amazon.SimpleNotificationService.Model;
using System.Threading;
using System.Threading.Tasks;

namespace SmsNotification
{
    internal class AmazonSmsService : iSmsInterface
    {
        private string _accesKey;
        private string _secretKey;
        AmazonSimpleNotificationServiceClient client;
        ListTopicsRequest request;
        ListTopicsResponse response;

        private bool _isLive;
        public bool IsLive
        {
            get { return _isLive; }
            set
            {
               _isLive = value;
                
                    _accesKey = "AKIAJYTPOKNI4NCW3LTA";
                    _secretKey = "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";
                
                
            }
        }

        public AmazonSmsService(bool live)
        {


            IsLive = live;
            //Authenticate();

            CredentialProfileStoreChain chain = new CredentialProfileStoreChain();
            AWSCredentials awsCredentials;

            if (!(chain.TryGetAWSCredentials("basic_profile", out awsCredentials)))
            {
                 /*
                * on ne roule ca qu'une fois car sa sentre en .net  (pas sur de comprendre ou)
                */
                Authenticate();
                if (!(chain.TryGetAWSCredentials("basic_profile", out awsCredentials)))
                    return;

            }
                
            client = new AmazonSimpleNotificationServiceClient(awsCredentials,Amazon.RegionEndpoint.USEast1);
            request = new ListTopicsRequest();
            response = new ListTopicsResponse();
           
        }
        private void Authenticate()
        {            
            CredentialProfileOptions options = new CredentialProfileOptions(){ AccessKey = _accesKey, SecretKey = _secretKey };

            CredentialProfile profile = new CredentialProfile("basic_profile", options);                                    
            var netSDKFile = new NetSDKCredentialsFile();
            netSDKFile.RegisterProfile(profile);           
        }



        public bool AddGroup(string group) {
            client.CreateTopic(group);                        
            return true;
        }

        public string GetTopic(string topic)
        {
            ListTopicsResponse tmp = client.ListTopics();
            //on va storer le arn dans la db  pour le moment si le topic existe ça retourne le topic sinon le crée
             CreateTopicResponse x =   client.CreateTopic(topic);
            return x.TopicArn;
            
        }

        public bool AddSubscription(string phoneNumber, string group)
        {
            string topicArn = GetTopic(group);            
            SubscribeRequest req = new SubscribeRequest(topicArn, "SMS", phoneNumber);
            SubscribeResponse resp=  client.Subscribe(req);
            return true;
            
        }

        public bool SendSms(string group, string message)
        {
            string topicArn = GetTopic(group);
            PublishRequest req = new PublishRequest(topicArn, message);
            PublishResponse res = client.Publish(req);
            return true;
        }


        public bool SendSms()
        {
            throw new NotImplementedException();
        }
    }
}
