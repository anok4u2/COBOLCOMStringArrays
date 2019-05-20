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
            return accounts[1];
        }
    }
}