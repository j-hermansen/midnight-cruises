using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for BasePage
/// </summary>
public class BasePage : System.Web.UI.Page
{
   protected string imagePath(string path, string alt)
   {

      if (path != "")
      {
         return path;
      }
      else
      {
         return alt;
      }

   }

}