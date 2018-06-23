using DW.Utilities;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class user_registration : System.Web.UI.Page
{
   string FID = "1";
   protected void Page_Load(object sender, EventArgs e)
   {
      Label tbx = ((Label)DetailsView1.Controls[0].FindControl("userLabel"));

      if (User.Identity.IsAuthenticated)
      {
         tbx.Text = User.Identity.Name.ToString();
      }

      if (Request.QueryString["ID"] != null)
      {
         FID = Request.QueryString["ID"];
      }

      countLabel.Text = db.mcSqlCommand("SELECT count(sign_ups.excursion_ID) AS Påmeldinger  FROM sign_ups JOIN excursions ON sign_ups.excursion_ID = excursions.excursion_ID JOIN boats ON excursions.boat_ID = boats.boat_ID WHERE sign_ups.excursion_ID = " + FID);

      availableSeats.Text = db.mcSqlCommand("SELECT (SELECT boats.capacity AS val1 FROM boats JOIN excursions ON boats.boat_ID = excursions.boat_ID  WHERE excursions.excursion_ID = " + FID + ") - (SELECT count(sign_ups.excursion_ID) AS val2 from sign_ups where sign_ups.excursion_ID = " + FID + ") as available_seats");

      excursionLabel.Text = db.mcSqlCommand("SELECT excursion_name FROM excursions WHERE excursion_ID = " + FID);
      priceLabel.Text = db.mcSqlCommand("SELECT CAST(price AS INT) FROM excursions WHERE excursion_ID = " + FID);


     
      if (Request.QueryString["sign_up_ID"] != null && !IsPostBack )
      {
         DetailsView1.ChangeMode(DetailsViewMode.ReadOnly);
         excursionLabel.Text = db.mcSqlCommand("SELECT excursion_name FROM excursions JOIN sign_ups ON excursions.excursion_ID = sign_ups.excursion_ID WHERE sign_up_ID = " + Request.QueryString["sign_up_ID"]);
         priceLabel.Text = db.mcSqlCommand("SELECT CAST(price AS INT) FROM excursions JOIN sign_ups ON excursions.excursion_ID = sign_ups.excursion_ID WHERE sign_up_ID = " + Request.QueryString["sign_up_ID"]);

      }

      LinkButton LinkButton1 = ((LinkButton)DetailsView1.Controls[0].FindControl("LinkButton1"));

      // Sjekker om utflukten er fullbooket og om en påmelding ikke skal endres fra 'min side', deretter deaktiveres kontrollene.
      if (availableSeats.Text.ToString() == "0" && Request.QueryString["sign_up_ID"] == null)
      {
         DetailsView1.Visible = false;
         Label fullLabel = new Label();
         fullLabel.Text = "Utflukten er fullbooket.";
         fullLabel.CssClass += " margin-top";
         not_available.Controls.Add(fullLabel);
         counter.Visible = false;

      }


   }


   protected void DetailsView1_ItemInserting(object sender, DetailsViewInsertEventArgs e)
   {
      TextBox otherInfo = ((TextBox)DetailsView1.Controls[0].FindControl("otherInfo"));

      mcSign.InsertCommand = "INSERT INTO sign_ups (excursion_ID, sign_up_user, sign_up_text) VALUES (" + FID + ",'" + User.Identity.Name.ToString() + "','" + otherInfo.Text.ToString() + "')";
   }


   protected void DetailsView1_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
   {
      Response.Redirect("~/user/default.aspx");
   }


   protected void DetailsView1_DataBound(object sender, EventArgs e)
   {
      Label tbx = ((Label)DetailsView1.Controls[0].FindControl("userLabel"));

      if (User.Identity.IsAuthenticated)
      {
         tbx.Text = User.Identity.Name.ToString();
      }


   }

   protected void DetailsView1_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
   {
      DetailsView1.ChangeMode(DetailsViewMode.ReadOnly);
      DetailsView1.DefaultMode = DetailsViewMode.ReadOnly;
   }
}