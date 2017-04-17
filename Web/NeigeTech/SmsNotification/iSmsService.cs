using System;
using System.Collections.Generic;
using System.Text;

namespace SmsNotification
{    
    interface iSmsInterface
    {      
        bool IsLive { get; set; }

        bool AddGroup(string group);   
        bool AddSubscription(string phoneNumber, string group);
        bool SendSms(string group, string message);
    }
}
