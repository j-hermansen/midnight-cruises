<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="excursions.aspx.cs" Inherits="excursions" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


   <section>

      <h2>Utflukter</h2>
      <div class="row count alert alert-info">
         <p>
            Vi har for tiden 
            <asp:Label ID="totalLabel" runat="server" Text="Label"></asp:Label> 
            registrerte utflukter der 
            <asp:Label ID="activeLabel" runat="server" Text="Label"></asp:Label> 
            utflukter er aktive og 
            <asp:Label ID="finishLabel" runat="server" Text="Label"></asp:Label> 
            utflukter er fullført
         </p>
      </div>
      <div class="row margin-top">
         <div class="input-group input-group-lg">
            <asp:TextBox ID="searchText" runat="server" CssClass="form-control" />
            <div class="input-group-btn">
               <asp:LinkButton ID="search_button" runat="server" CssClass="btn btn-default" OnClick="search_button_Click">
                 <i aria-hidden="true" class="glyphicon glyphicon-search"></i>
               </asp:LinkButton>
            </div>
         </div>
      </div>

   </section>


   <section>

      <div class="filter-links btn-group">
         <asp:LinkButton ID="all_entries" CssClass="btn btn-default" runat="server" OnClick="all_entries_Click">
            Alle utflukter
         </asp:LinkButton>
         <asp:LinkButton ID="popular_entries" CssClass="btn btn-default" runat="server" OnClick="popular_entries_Click">
            Mest populære
         </asp:LinkButton>
      </div>
      <p>Sorter etter</p>
      <div class="filter-links btn-group t-m-0">
          <asp:LinkButton ID="sort_days" CssClass="btn btn-default" runat="server" OnClick="sort_days_Click">
            Antall dager
         </asp:LinkButton>
         <asp:LinkButton ID="sort_price" CssClass="btn btn-default" runat="server" OnClick="sort_price_Click">
            Pris
         </asp:LinkButton>
         <asp:LinkButton ID="sort_date" CssClass="btn btn-default" runat="server" OnClick="sort_date_Click">
            Dato
         </asp:LinkButton>
      </div>
      <div class="row">
         <asp:DataList ID="DataList1" runat="server"  
            DataSourceID="mcExcursions" 
            DataKeyField="excursion_ID">
               <ItemTemplate>
                  <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# Eval("excursion_ID", "~/default.aspx?ID={0}") %>'>

                     <div class="box row">
                        <div class="col-md-7 box-col-1">
                           <div class="row">
                              <h3>
                                 <asp:Label ID="excursion_nameLabel" CssClass="box-heading" runat="server" Text='<%# Eval("excursion_name") %>' />
                              </h3>
                           </div>
                           <div class="row">
                              <asp:Label ID="excursion_dateLabel" runat="server" Text='<%# Eval("excursion_date", "{0:d}") %>' />
                           </div>
                           <div class="row">
                              <asp:Label ID="destinationLabel" runat="server" Text='<%# Eval("destination") %>' />
                           </div>
                        </div>
                        <div class="col-md-1 box-col-2">
                           <div class="row">
                              <asp:Label ID="durationLabel" runat="server" CssClass="box-days" Text='<%# Eval("duration") %>' />
                           </div>
                           <div class="row">
                              <p>Dager</p>
                           </div>
                        </div>
                        <div class="col-md-2 box-col-3">
                           <div class="row">
                              <asp:Label ID="priceLabel" runat="server" CssClass="box-price" Text='<%# Eval("price", "{0:n0}") %>' />
                           </div>
                           <div class="row">
                              <p>Kr per pers</p>
                           </div>
                        </div>
                        <div class="col-md-2 box-col-4">
                           <asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl='<%# Eval("excursion_ID", "user/registration.aspx?ID={0}") %>'>
                              <div class="row">
                                  <i class="glyphicon glyphicon-check"></i>
                              </div>
                              <div class="row">
                                 <p>Meld på</p>
                              </div>
                           </asp:HyperLink>
                        </div>
                     </div>
                  </asp:HyperLink></ItemTemplate><FooterTemplate>
               <asp:Label Visible='<%# bool.Parse((DataList1.Items.Count==0).ToString())%>' runat="server" ID="lblNoRecord" Text="Ingen kommende utflukter funnet.">
               </asp:Label>
            </FooterTemplate>
         </asp:DataList>
         
         <asp:SqlDataSource ID="mcExcursions" runat="server" 
            ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
            SelectCommand="SELECT excursions.excursion_ID, excursions.excursion_name, excursions.excursion_date, excursions.duration, excursions.price, excursions.excursion_description, excursions.url, boats.boat_name, boats.foot, boats.boat_year, boats.boat_owner, destinations.destination FROM excursions JOIN boats ON excursions.boat_ID = boats.boat_ID JOIN excursions_destinations ON excursions.excursion_ID = excursions_destinations.excursion_ID JOIN destinations ON excursions_destinations.destination_ID = destinations.destination_ID WHERE excursions.excursion_date > GETDATE() ORDER BY excursions.excursion_date">
         </asp:SqlDataSource>
      </div>

   </section>

   <hr />

   <section>
      <h2>Fullførte utflukter</h2>
      <asp:DataList ID="DataList2" runat="server" DataKeyField="excursion_ID" DataSourceID="mcComplete">
         <ItemTemplate>
            <div class="box box-complete disabled row">
               <div class="col-md-7 box-col-1">
                  <div class="row">
                     <h3>
                        <asp:Label ID="excursion_nameLabel" CssClass="box-heading" runat="server" Text='<%# Eval("excursion_name") %>' />
                     </h3>
                  </div>
                  <div class="row">
                     <asp:Label ID="excursion_dateLabel" runat="server" Text='<%# Eval("excursion_date", "{0:d}") %>' />
                  </div>
                  <div class="row">
                     <asp:Label ID="destinationLabel" runat="server" Text='<%# Eval("destination") %>' />
                  </div>
               </div>
            </div>
         </ItemTemplate>
         <FooterTemplate>
            <asp:Label Visible='<%# bool.Parse((DataList2.Items.Count==0).ToString())%>' runat="server" ID="lblNoRecord" Text="Ingen fullførte utflukter funnet.">
            </asp:Label>
         </FooterTemplate>
      </asp:DataList>

      <asp:SqlDataSource ID="mcComplete" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT excursions.excursion_ID, excursions.excursion_name, excursions.excursion_date, excursions.duration, excursions.price, excursions.excursion_description, excursions.url, boats.boat_name, boats.foot, boats.boat_year, boats.boat_owner, destinations.destination FROM excursions JOIN boats ON excursions.boat_ID = boats.boat_ID JOIN excursions_destinations ON excursions.excursion_ID = excursions_destinations.excursion_ID JOIN destinations ON excursions_destinations.destination_ID = destinations.destination_ID WHERE excursions.excursion_date &lt; GETDATE() ORDER BY excursions.excursion_date">
      </asp:SqlDataSource>

   </section>

</asp:Content>

