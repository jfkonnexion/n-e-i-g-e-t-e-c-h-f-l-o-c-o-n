using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SmsNotification.Exeption
{
    
    public class CantAuthenticateToService : Exception
    {
        public CantAuthenticateToService() {}

        public CantAuthenticateToService(string message): base(message)
        {
        }

        public CantAuthenticateToService(string message, Exception inner): base(message, inner)
        {

        }
    }
}
