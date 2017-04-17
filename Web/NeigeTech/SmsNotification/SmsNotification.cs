using System;

namespace SmsNotification
{
    public class SmsNotifier
    {
        private iSmsInterface smsService;
        public SmsNotifier(bool liveMode)
        {
            smsService = new AmazonSmsService(liveMode);
        }
        public bool AddGroup(string group){
            return smsService.AddGroup(group);
        }
        public bool AddSubscription(string number, string group)
        {
            return smsService.AddSubscription(number, group);
        }
        public bool SendSms(string group, string message)
        {
            return smsService.SendSms(group, message);
        }
    }
}
