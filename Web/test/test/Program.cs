using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Windows.Forms;
using SmsNotification;
namespace test
{
    static class Program
    {
        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            SmsNotifier sm = new SmsNotifier(false);
            
           // sm.AddGroup("test");
           // sm.AddSubscription("14184553547", "test");
            sm.SendSms("test", "Ce message sera envoyé à trois numéros différents! It works!");
            //Application.Run(new Form1());
        }
    }
}
