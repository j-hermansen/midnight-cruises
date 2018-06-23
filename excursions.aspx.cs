using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DW.Utilities;

public partial class excursions : System.Web.UI.Page
{
   protected void Page_Load(object sender, EventArgs e)
   {

      //Hindrer at siden hopper til toppen ved 'autopostback'.
      Page.MaintainScrollPositionOnPostBack = true;

      // Viser totale påmeldinger, totalt aktive og fullførte.
      totalLabel.Text = db.mcSqlCommand("SELECT COUNT(*) FROM excursions");
      activeLabel.Text = db.mcSqlCommand("SELECT COUNT(*) FROM excursions WHERE excursion_date > GETDATE()");
      finishLabel.Text = db.mcSqlCommand("SELECT COUNT(*) FROM excursions WHERE excursion_date < GETDATE()");

   }

   protected void search_button_Click(object sender, EventArgs e)
   {

      //Søk for aktive utflukter.
      mcExcursions.SelectCommand = "SELECT * FROM excursions JOIN boats ON excursions.boat_ID = boats.boat_ID JOIN excursions_destinations ON excursions.excursion_ID = excursions_destinations.excursion_ID JOIN destinations ON excursions_destinations.destination_ID = destinations.destination_ID WHERE excursion_date > GETDATE() AND excursion_name LIKE '%" + searchText.Text + "%' OR destination LIKE '%" + searchText.Text + "%' ORDER BY excursion_date";

      //Søk for inaktive utflukter.
      mcComplete.SelectCommand = "SELECT * FROM excursions JOIN boats ON excursions.boat_ID = boats.boat_ID JOIN excursions_destinations ON excursions.excursion_ID = excursions_destinations.excursion_ID JOIN destinations ON excursions_destinations.destination_ID = destinations.destination_ID WHERE excursion_date < GETDATE() AND (excursion_name LIKE '%" + searchText.Text + "%' OR destination LIKE '%" + searchText.Text + "%')";

   }

   protected void all_entries_Click(object sender, EventArgs e)
   {

      // Henter ut alle utflukter som ikke har vært, sortert etter navn.
      mcExcursions.SelectCommand = "SELECT excursions.excursion_ID, excursions.excursion_name, excursions.excursion_date, excursions.duration, excursions.price, excursions.excursion_description, excursions.url, boats.boat_name, boats.foot, boats.boat_year, boats.boat_owner, destinations.destination FROM excursions JOIN boats ON excursions.boat_ID = boats.boat_ID JOIN excursions_destinations ON excursions.excursion_ID = excursions_destinations.excursion_ID JOIN destinations ON excursions_destinations.destination_ID = destinations.destination_ID WHERE excursions.excursion_date > GETDATE() ORDER BY excursions.excursion_name";

   }

   protected void popular_entries_Click(object sender, EventArgs e)
   {
      
      // Henter ut utflukter med mest påmeldinger, sortert fra mest til minst.
      mcExcursions.SelectCommand = "SELECT TOP 3 excursions.excursion_ID, excursions.excursion_name, COUNT(sign_ups.excursion_ID) AS 'count', excursions.excursion_date, excursions.duration, excursions.price, excursions.excursion_description, boats.boat_name, boats.foot, boats.boat_year, boats.boat_owner, destinations.destination FROM excursions JOIN boats ON excursions.boat_ID = boats.boat_ID JOIN sign_ups ON excursions.excursion_ID = sign_ups.excursion_ID JOIN excursions_destinations ON excursions.excursion_ID = excursions_destinations.excursion_ID JOIN destinations ON excursions_destinations.destination_ID = destinations.destination_ID WHERE excursions.excursion_date > GETDATE() GROUP BY excursions.excursion_name, sign_ups.excursion_ID,excursions.excursion_ID, excursions.excursion_date, excursions.duration, excursions.price, excursions.excursion_description, boats.boat_name, boats.foot, boats.boat_year, boats.boat_owner, destinations.destination ORDER BY 'count' DESC";

   }



   protected void sort_days_Click(object sender, EventArgs e)
   {

      mcExcursions.SelectCommand = "SELECT excursions.excursion_ID, excursions.excursion_name, excursions.excursion_date, excursions.duration, excursions.price, excursions.excursion_description, excursions.url, boats.boat_name, boats.foot, boats.boat_year, boats.boat_owner, destinations.destination FROM excursions JOIN boats ON excursions.boat_ID = boats.boat_ID JOIN excursions_destinations ON excursions.excursion_ID = excursions_destinations.excursion_ID JOIN destinations ON excursions_destinations.destination_ID = destinations.destination_ID WHERE excursions.excursion_date > GETDATE() ORDER BY excursions.duration DESC";

   }

   protected void sort_price_Click(object sender, EventArgs e)
   {

      mcExcursions.SelectCommand = "SELECT excursions.excursion_ID, excursions.excursion_name, excursions.excursion_date, excursions.duration, excursions.price, excursions.excursion_description, excursions.url, boats.boat_name, boats.foot, boats.boat_year, boats.boat_owner, destinations.destination FROM excursions JOIN boats ON excursions.boat_ID = boats.boat_ID JOIN excursions_destinations ON excursions.excursion_ID = excursions_destinations.excursion_ID JOIN destinations ON excursions_destinations.destination_ID = destinations.destination_ID WHERE excursions.excursion_date > GETDATE() ORDER BY excursions.price DESC";

   }

   protected void sort_date_Click(object sender, EventArgs e)
   {

      mcExcursions.SelectCommand = "SELECT excursions.excursion_ID, excursions.excursion_name, excursions.excursion_date, excursions.duration, excursions.price, excursions.excursion_description, excursions.url, boats.boat_name, boats.foot, boats.boat_year, boats.boat_owner, destinations.destination FROM excursions JOIN boats ON excursions.boat_ID = boats.boat_ID JOIN excursions_destinations ON excursions.excursion_ID = excursions_destinations.excursion_ID JOIN destinations ON excursions_destinations.destination_ID = destinations.destination_ID WHERE excursions.excursion_date > GETDATE() ORDER BY excursions.excursion_date ASC";

   }
}