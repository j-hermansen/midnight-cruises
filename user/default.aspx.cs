using System;
using System.Collections.Generic;
using System.Linq;
using System.Configuration;
using System.Web;
using System.Web.UI;
using System.Data.SqlClient;
using System.Data;
using System.Web.UI.WebControls;
using DW.Utilities;

public partial class user_default : System.Web.UI.Page
{


   protected void Page_Load(object sender, EventArgs e)
   {
      //Hindrer at siden hopper til toppen ved 'autopostback'.
      Page.MaintainScrollPositionOnPostBack = true;

      TextBox fulltnavn = ((TextBox)member_view.Controls[0].FindControl("fulltnavn")); 
      TextBox profilbilde = ((TextBox)member_view.Controls[0].FindControl("profilbilde"));

      GridView GridView1 = ((GridView)member_view.Controls[0].FindControl("GridView1"));

      if (!IsPostBack)
      {

         GridView1.DataBind();

         //Tekstboksene på 'Min side' setter inn lagret navn og bildeurl.
         fulltnavn.Text = Profile.navn;
         profilbilde.Text = Profile.bilde;

      }

      Image Image1 = ((Image)member_view.Controls[0].FindControl("Image1"));

      //Legger bildeurl til imageurl.
      if (profilbilde.Text != null)
      {
         Image1.ImageUrl = profilbilde.Text;
      }

      if (User.IsInRole("admins"))
      { 

         //Viser totale påmeldinger
         Label registered_entries = ((Label)member_view.Controls[0].FindControl("registered_entries"));
         registered_entries.Text = db.mcSqlCommand("SELECT COUNT(*) FROM sign_ups");

      }
      else
      {

         //Viser antall påmeldinger bruker har.
         Label registered_entries = ((Label)member_view.Controls[0].FindControl("registered_entries"));
         registered_entries.Text = db.mcSqlCommand("SELECT COUNT(*) FROM sign_ups WHERE sign_up_user = '" + User.Identity.Name.ToLower().ToString() + "'");

      }

      // Viser bare påmeldingene til innlogget bruker om bruker ikke er administrator.
      if (!User.IsInRole("admins")) 
      {

         mcUserSignups.SelectCommand = "SELECT excursions.excursion_name, excursions.excursion_date, sign_ups.sign_up_ID, sign_ups.excursion_ID, sign_ups.sign_up_user, sign_ups.registered_date, CASE WHEN sign_ups.paid = 1 THEN 'Ja' ELSE 'Nei' END AS paid FROM excursions INNER JOIN sign_ups ON excursions.excursion_ID = sign_ups.excursion_ID WHERE sign_ups.sign_up_user = '" + User.Identity.Name.ToLower().ToString() + "'";

      }
   } 

   protected void CheckBox1_CheckedChanged(object sender, EventArgs e)
   {

      GridView GridView1 = ((GridView)member_view.Controls[0].FindControl("GridView1")); //Finner GridView1 datatabell

      CheckBox chkStatus = (CheckBox)sender;
      Int64 nID = Convert.ToInt64(GridView1.DataKeys[((GridViewRow)chkStatus.NamingContainer).RowIndex].Value);

      //Oppdaterer betaling (paid).
      string sQuery = "UPDATE sign_ups SET paid = @paid WHERE sign_up_ID = @sign_up_ID";
      string consString = ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
      using (SqlConnection conn = new SqlConnection(consString))
      {
         SqlCommand com = new SqlCommand(sQuery, conn);

         com.Parameters.Add("@paid", SqlDbType.Bit).Value = chkStatus.Checked;
         com.Parameters.Add("@sign_up_ID", SqlDbType.Int).Value = nID;

         conn.Open();
         com.ExecuteNonQuery();
      }

      GridView1.DataBind();

      GridView1.HeaderRow.TableSection = TableRowSection.TableHeader;

   }

   protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
   {
      //Gjør radene i gridview til linker som fører til en visning av påmeldelsen.
      if (e.Row.RowType == DataControlRowType.DataRow)
      {

         string LeadID = DataBinder.Eval(e.Row.DataItem, "sign_up_ID").ToString();
         string Location = ResolveUrl("~/user/registration.aspx") + "?sign_up_ID=" + LeadID;
         e.Row.Attributes["onClick"] = string.Format("javascript:window.location='{0}';", Location);
         e.Row.Style["cursor"] = "pointer";

      }

   }

   protected void Button1_Click(object sender, EventArgs e)
   {
      TextBox fulltnavn = ((TextBox)member_view.Controls[0].FindControl("fulltnavn"));
      TextBox profilbilde = ((TextBox)member_view.Controls[0].FindControl("profilbilde"));

      // Lagrer navn til profil.
      Profile.navn = fulltnavn.Text;
      Profile.bilde = profilbilde.Text;

      // Laster om for å oppdatere profilbilde.
      Server.Transfer("~/user/default.aspx");
   }

   protected void GridView1_PreRender(object sender, EventArgs e)
   {
      GridView GridView1 = ((GridView)member_view.Controls[0].FindControl("GridView1"));

      // Setter opp 'thead' og 'tfoot' til tabell for rikitg stilsetting fra bootstrap.
      if (GridView1.Rows.Count > 0)
      {

         GridView1.HeaderRow.TableSection = TableRowSection.TableHeader;
         GridView1.BottomPagerRow.TableSection = TableRowSection.TableFooter;
      }
   }

   protected void my_entries_Click(object sender, EventArgs e)
   {

      // Viser egne påmeldinger for administratorer.
      mcSignups.SelectCommand = "SELECT excursions.excursion_name, excursions.excursion_date, sign_ups.sign_up_ID, sign_ups.excursion_ID, sign_ups.sign_up_user, sign_ups.registered_date, sign_ups.paid FROM excursions INNER JOIN sign_ups ON excursions.excursion_ID = sign_ups.excursion_ID WHERE sign_ups.sign_up_user = '" + User.Identity.Name.ToLower().ToString() + "'";

   }

   protected void all_entries_Click(object sender, EventArgs e)
   {

      //Viser alle påmeldinger
      mcSignups.SelectCommand = "SELECT excursions.excursion_name, excursions.excursion_date, sign_ups.sign_up_ID, sign_ups.excursion_ID, sign_ups.sign_up_user, sign_ups.registered_date, sign_ups.paid FROM excursions INNER JOIN sign_ups ON excursions.excursion_ID = sign_ups.excursion_ID";

   }

   protected void GridView1_DataBound(object sender, EventArgs e)
   {

      GridView GridView1 = ((GridView)member_view.Controls[0].FindControl("GridView1"));

      //Loop for å deaktivere 'delete'-knapp vis utflukten er betalt.
      for (int i = 0; i < GridView1.Rows.Count; i++)
      {
         // Finner om batalingen er 'Ja' eller 'Nei'.
         string name = GridView1.Rows[i].Cells[3].Text;

         // Hvis utflukten er betalt('Ja') så søkes 'delete'-knapp i siste kolonne og fjerner den.
         if (name == "Ja")
         {
            GridView1.Rows[i].Cells[4].Controls[0].Visible = false;
         }

      }
   }

}
