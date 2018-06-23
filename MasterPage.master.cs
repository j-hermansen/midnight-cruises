using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MasterPage : System.Web.UI.MasterPage
{
   protected void Page_Load(object sender, EventArgs e)
   {
 
   }

   protected void DataList1_ItemDataBound(object sender, DataListItemEventArgs e)
   {
      if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
      {

         Label destinationLabel = e.Item.FindControl("destinationLabel") as Label;

         string bgImage = "/images/" + destinationLabel.Text.ToLower().ToString() + "-front.jpg";

         // Sjekker om destinasjonen har et '-front' bilde.
         if (File.Exists(Server.MapPath(bgImage))) 
         {
            // legger inn 'hovedbilde' bilde etter hvilken destinasjon som vises.
            e.Item.Attributes.Add("Style", "background: linear-gradient(rgba(27, 50, 95, 0.50), rgba(27, 50, 95, 0.50)), url('/images/" + destinationLabel.Text.ToLower().ToString() + "-front.jpg') no-repeat center; background-size: cover; display: block;");
         }
         else
         {
            // Hvis ingen 'Hovedbilde' finnes så vises et standard bilde.
            e.Item.Attributes.Add("Style", "background: linear-gradient(rgba(27, 50, 95, 0.55), rgba(27, 50, 95, 0.55)), url('/images/default.jpg') no-repeat center; background-size: cover; display: block;");
         }

      }
   }
}
