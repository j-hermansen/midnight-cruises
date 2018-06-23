<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="default.aspx.cs" Inherits="_default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

      <section>

         <div class="row more-info">
            <h2>Båtforeningen i Nordland</h2>
            <p>
               Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed gravida lorem ac odio egestas, ut pharetra enim luctus. Etiam diam libero, lacinia quis lorem at, lacinia vulputate magna. In hac habitasse platea dictumst. Donec vel nunc lacinia, blandit magna eu, mollis libero. Donec in dui semper dolor pharetra commodo. Maecenas laoreet nec massa at pretium. Integer fringilla arcu ac lorem iaculis dignissim. Phasellus feugiat nisl vitae ligula suscipit vulputate. Nullam ac venenatis tortor.
            </p>
            <asp:Button ID="new_user" runat="server" Text="Registrer ny bruker" OnClick="new_user_Click" CssClass="btn btn-danger btn-style b-shadow" />
         </div>

      </section>

      <hr />

      <section>

          <asp:FormView ID="FormView1" runat="server" DataSourceID="mcOneExcursion" CssClass="trip1" DataKeyField="excursion_ID,ID">
            <ItemTemplate>
                <div class="row">
                  <div class="col-md-6">
                     <div class="bg-img-container">
                  <asp:Image ID="Image2" runat="server" CssClass="i-shadow" ImageUrl='<%# imagePath(Eval("excursion_image", "~/images/{0}").ToString(), "~/images/default.jpg") %>' />
                     <h3>
                        <asp:Label ID="Label1" runat="server" CssClass="t-shadow" Text='<%# Bind("excursion_name") %>' />
                     </h3>
                     <p>
                        <asp:Label ID="Label2" runat="server" CssClass="t-shadow" Text='<%# Bind("excursion_date", "{0:d}") %>' />
                     </p>
                     <asp:LoginView ID="LoginView1" runat="server">
                        <AnonymousTemplate>
                           <asp:Button ID="btnLogin" runat="server" Text="Logg inn" CssClass="btn btn-danger btn-style b-shadow" OnClick="btnLogin_Click" />
                        </AnonymousTemplate>
                        <LoggedInTemplate>
                           <asp:HyperLink  ID="btnRegistration" runat="server" CssClass="btn btn-danger btn-style enabled" NavigateUrl='<%# Eval("excursion_ID","user/registration.aspx?ID={0}") %>' OnPreRender="btnRegistration_PreRender">Påmelding</asp:HyperLink>
                        </LoggedInTemplate>
                     </asp:LoginView>
                     <div class="available">
                            <strong><asp:Label ID="countLabel" runat="server" Text="Label"></asp:Label> </strong>
                           <span>ledige plasser.</span>
                     </div>
                  </div>
                        
                  </div>

                  <div class="col-md-6">
                     <h3 class="t-m-0">Kort informasjon om utflukten</h3>
                     <div class="form-group row">
                        <p class="col-sm-3 bold">Antall dager:</p>
                        <div class="col-sm-9">
                           <asp:Label ID="Label3" runat="server" Text='<%# Bind("duration") %>' />
                        </div>
                     </div>
                     <div class="form-group row">
                        <p class="col-sm-3 bold">Pris per person:</p>
                        <div class="col-sm-9">
                           <asp:Label ID="Label4" runat="server" Text='<%# Bind("price", "{0:c0}") %>' />
                        </div>
                     </div>
                     <div class="form-group row">
                        <p class="col-sm-3 bold">Beskrivelse:</p>
                        <div class="col-sm-9">
                           <asp:Label ID="Label5" runat="server" Text='<%# Bind("excursion_description") %>' />
                        </div>
                     </div>
                     <div class="form-group row">
                        <p class="col-sm-3 bold">Destinasjon:</p>
                        <div class="col-sm-9">
                           <asp:Label ID="Label6" runat="server" Text='<%# Bind("destination") %>' />
                        </div>
                     </div>
                     <div class="form-group row">
                        <p class="col-sm-3 bold">Båt:</p>
                        <div class="col-sm-9">
                           <asp:Label ID="boat_nameLabel" runat="server" Text='<%# Bind("boat_name") %>' />
                        </div>
                     </div>
                     <div class="form-group row">
                        <p class="col-sm-3 bold">Fot:</p>
                        <div class="col-sm-9">
                           <asp:Label ID="footLabel" runat="server" Text='<%# Bind("foot") %>' />
                        </div>
                     </div>
                     <div class="form-group row">
                        <p class="col-sm-3 bold">Kapasitet:</p>
                        <div class="col-sm-9">
                           <asp:Label ID="capacityLabel" runat="server" Text='<%# Bind("capacity") %>' />
                        </div>
                     </div>
                     <div class="form-group row">
                        <p class="col-sm-3 bold">Eier:</p>
                        <div class="col-sm-9">
                           <asp:Label ID="Label7" runat="server" Text='<%# Bind("boat_owner") %>' />
                        </div>
                     </div>
                  </div>
               </div>
            </ItemTemplate>
         </asp:FormView>

         <asp:SqlDataSource ID="mcOneExcursion" runat="server" 
            ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
            SelectCommand="SELECT TOP 1 * FROM excursions INNER JOIN excursions_destinations ON excursions.excursion_ID = excursions_destinations.excursion_ID INNER JOIN destinations ON excursions_destinations.destination_ID = destinations.destination_ID INNER JOIN boats ON excursions.boat_ID = boats.boat_ID LEFT OUTER JOIN excursion_images ON excursions.excursion_ID = excursion_images.excursion_ID WHERE excursion_date > GETDATE() AND (excursion_image LIKE '%front%' OR excursion_image IS NULL) ORDER BY excursion_date">
            <SelectParameters>
               <asp:QueryStringParameter Name="excursion_ID" QueryStringField="ID" Type="Int32" DefaultValue="0" />
            </SelectParameters>
         </asp:SqlDataSource>

      </section>

</asp:Content>

