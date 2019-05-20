using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Runtime.InteropServices;

namespace CheckAccountNumber
{
    [Guid("A80930D1-080F-4B04-A2C3-B637428556D6")]
    public interface IAccountNumbers
    {
        [DispId(1)]
        string CheckAccount(string[] accounts);
        [DispId(2)]
        string CheckAccount2d(string[,] accounts);
    }

    [Guid("65A771A0-0DDE-440D-9A4F-C71CEAEE3DF6"),
    ClassInterface(ClassInterfaceType.None)]
    public class AccountNumbers : IAccountNumbers
    {
        public AccountNumbers()
        {
        }

        public string CheckAccount(string[] accounts)
        {
            Console.WriteLine("Entered CheckAccount 1D");
            // Show passed strings from COBOL
            foreach(string str in accounts)
            {
                Console.WriteLine("From COBOL : " + str);
            }
            Console.WriteLine("Leaving CheckAccount 1D");
            return accounts[1];
        }

        public string CheckAccount2d(string[,] accounts)
        {
            Console.WriteLine("Entered CheckAccount 2D");
            // Show passed strings from COBOL
            foreach(string str in accounts)
            {
                Console.WriteLine("From COBOL : " + str);
            }
            Console.WriteLine("accounts[1,2]="+accounts[1,2]);
            Console.WriteLine("Leaving CheckAccount 2D");
            return accounts[1,1];
        }

    }
}