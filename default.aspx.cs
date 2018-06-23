using DW.Utilities;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _default : BasePage
{
   protected void Page_Load(object sender, EventArgs e)
   {
      //Sjekker om utflukt er valgt og gjør om select query.
      if (Request.QueryString["ID"] != null) 
      {

         mcOneExcursion.SelectCommand = "SELECT * FROM excursions INNER JOIN excursions_destinations ON excursions.excursion_ID = excursions_destinations.excursion_ID INNER JOIN destinations ON excursions_destinations.destination_ID = destinations.destination_ID INNER JOIN boats ON excursions.boat_ID = boats.boat_ID LEFT OUTER JOIN excursion_images ON excursions.excursion_ID = excursion_images.excursion_ID WHERE excursion_date > GETDATE() AND (excursion_image LIKE '%front%' OR excursion_image IS NULL) AND excursions.excursion_ID = @excursion_ID";

      }

      Label countLabel = ((Label)FormView1.Controls[0].FindControl("countLabel"));

      if (Request.QueryString["ID"] != null)
      {

         // Regner ut ledige plasser (kapasitet - antall påmeldinger)
         countLabel.Text = db.mcSqlCommand("SELECT (SELECT boats.capacity AS val1 FROM boats JOIN excursions ON boats.boat_ID = excursions.boat_ID  WHERE excursions.excursion_ID = " + Request.QueryString["ID"] + ") - (SELECT count(sign_ups.excursion_ID) AS val2 from sign_ups where sign_ups.excursion_ID = " + Request.QueryString["ID"] + ") as available_seats");

      }

      else
      {
        
         // Finner og lagrer excursion_ID til nærmeste utflukt.
         string defaultID = db.mcSqlCommand("SELECT TOP 1 excursion_ID FROM excursions WHERE excursion_date > GETDATE() ORDER BY excursion_date");

         // Bruker defaultID for å finne utflukt som er nærmenst ut fra dato.
         countLabel.Text = db.mcSqlCommand("SELECT (SELECT boats.capacity AS val1 FROM boats JOIN excursions ON boats.boat_ID = excursions.boat_ID  WHERE excursions.excursion_ID = " + defaultID + ") - (SELECT count(sign_ups.excursion_ID) AS val2 from sign_ups where sign_ups.excursion_ID = " + defaultID + ") as available_seats");

      }

   }

   protected void btnLogin_Click(object sender, EventArgs e)
   {
      Response.Redirect("~/login.aspx");
   }

   protected void new_user_Click(object sender, EventArgs e)
   {
      Response.Redirect("~/signup.aspx");
   }



   protected void btnRegistration_PreRender(object sender, EventArgs e)
   {

      Label countLabel = ((Label)FormView1.Controls[0].FindControl("countLabel"));
      LoginView LoginView1 = ((LoginView)FormView1.Controls[0].FindControl("LoginView1"));
      HyperLink btnRegistration = ((HyperLink)LoginView1.Controls[0].FindControl("btnRegistration"));

      //Sjekker om ikke er flere ledige plasser og deaktiverer påmeldingsknapp.
      if (countLabel.Text.ToString() == "0")
      {
         btnRegistration.CssClass = btnRegistration.CssClass.Replace("enabled", "disabled");
      }

   }
}