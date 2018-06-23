using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace DW.Utilities
{
   /// <summary>
   /// Summary description for db
   /// </summary>
   public class db
   {
      public static string mcSqlCommand(string command)
      {

         string connStr = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
         SqlConnection conn = new SqlConnection(connStr);
         conn.Open();
         SqlCommand cmd = new SqlCommand(command, conn);
         object value = cmd.ExecuteScalar();
         conn.Close();
         if (value != null)
         {
            return value.ToString();
         }
         else
         {
            return "";
         }

      }

   }

}