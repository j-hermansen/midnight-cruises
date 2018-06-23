<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="default.aspx.cs" Inherits="user_default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
      
   <div class="member-site">

     <h2>Profil</h2>

     <asp:LoginView ID="member_view" runat="server">

      <AnonymousTemplate>

      </AnonymousTemplate>

      <LoggedInTemplate>
         <section class="profile_info">

            <div class="row text-center">
               <asp:Image ID="Image1" runat="server" ImageUrl="~/images/user.png" CssClass="profile_img img-thumbnail b-shadow" />
               <asp:LoginName ID="LoginName2" runat="server" CssClass="profile_username" />
            </div>
            <div class="form-group">
               <p>Fullt navn</p>
               <asp:TextBox ID="fulltnavn" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
            <div class="row">
               <p>Profilbilde url</p>
               <asp:TextBox ID="profilbilde" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
             <div class="row text-right margin-top">
                <asp:Button ID="Button1" runat="server" Text="Lagre" CssClass="btn btn-default" OnClick="Button1_Click" />
            </div>

         </section>

         <hr />

         <section>

            <p>Her er en oversikt over dine påmeldinger:</p>

            <p>
               <small>
                  <asp:Label ID="registered_entries" runat="server" Text="Label"></asp:Label> 
                  påmeldinger registrert.
               </small>
            </p>

            <asp:GridView ID="GridView1" runat="server" 
               DataSourceID="mcUserSignups" 
               AllowPaging="True" 
               AllowSorting="True" 
               AutoGenerateColumns="False" 
               DataKeyNames="sign_up_ID" 
               PagerStyle-CssClass="paging_style" 
               GridLines="None"
               OnPreRender="GridView1_PreRender"
               OnRowDataBound="GridView1_RowDataBound" 
               PageSize="5" 
               OnDataBound="GridView1_DataBound" >
               <Columns>
                  <asp:BoundField DataField="excursion_name" HeaderText="Utflukt" SortExpression="excursion_name"></asp:BoundField>
                  <asp:BoundField DataField="excursion_date" HeaderText="Dato" SortExpression="excursion_date"></asp:BoundField>
                  <asp:BoundField DataField="registered_date" HeaderText="Påmeldt dato" SortExpression="registered_date"></asp:BoundField>
                  <asp:BoundField DataField="paid" HeaderText="Betalt" SortExpression="paid"></asp:BoundField>
                  <asp:CommandField ShowDeleteButton="True" DeleteText="Slett"></asp:CommandField>
               </Columns>
            </asp:GridView>

         </section>
      </LoggedInTemplate>

      <RoleGroups>

         <asp:RoleGroup Roles="admins">
            <ContentTemplate>
               <section class="profile_info">

                  <div class="row text-center">
                     <asp:Image ID="Image1" runat="server" ImageUrl="~/images/user.png" CssClass="profile_img img-thumbnail b-shadow" />
                     <asp:LoginName ID="LoginName2" runat="server" CssClass="profile_username" />
                  </div>
                  <div class="form-group">
                     <p>Fullt navn</p>
                     <asp:TextBox ID="fulltnavn" runat="server" CssClass="form-control"></asp:TextBox>
                  </div>
                  <div class="row">
                     <p>Profilbilde url</p>
                     <asp:TextBox ID="profilbilde" runat="server" CssClass="form-control"></asp:TextBox>
                  </div>
                   <div class="row text-right margin-top">
                      <asp:Button ID="Button1" runat="server" Text="Lagre" CssClass="btn btn-default" OnClick="Button1_Click" />
                  </div>

               </section>

               <hr />

               <section>

               <h2>Påmeldinger</h2>

               <p>
                  <small>
                     <asp:Label ID="registered_entries" runat="server" Text="Label"></asp:Label> 
                     påmeldinger registrert.
                  </small>
               </p>

               <div class="filter-links btn-group">
                  <asp:LinkButton ID="all_entries" CssClass="btn btn-default" runat="server" OnClick="all_entries_Click">Alle påmeldinger</asp:LinkButton>
                  <asp:LinkButton ID="my_entries" CssClass="btn btn-default" runat="server" OnClick="my_entries_Click">Mine påmeldinger</asp:LinkButton>
               </div>

               <div class="table-responsive">
                  <asp:GridView ID="GridView1" runat="server"
                     AutoGenerateColumns="False"
                     DataKeyNames="sign_up_ID"
                     DataSourceID="mcSignups"
                     AllowPaging="True"
                     AllowSorting="True"
                     GridLines="None"
                     PagerStyle-CssClass="paging_style" 
                     OnRowDataBound="GridView1_RowDataBound" 
                     OnPreRender="GridView1_PreRender" 
                     PageSize="10">
                     <Columns>

                        <asp:BoundField DataField="sign_up_user" HeaderText="Brukernavn" SortExpression="sign_up_user"></asp:BoundField>
                        <asp:BoundField DataField="excursion_name" HeaderText="Utflukt" SortExpression="excursion_name"></asp:BoundField>
                        <asp:BoundField DataField="excursion_date" HeaderText="Dato" DataFormatString="{0:D}" SortExpression="excursion_date"></asp:BoundField>
                        <asp:BoundField DataField="registered_date" HeaderText="Påmeldt dato" DataFormatString="{0:g}" SortExpression="registered_date"></asp:BoundField>
                        <asp:TemplateField HeaderText="Betalt" SortExpression="paid">
                           <EditItemTemplate>
                              <asp:CheckBox runat="server" Checked='<%# Bind("paid") %>' ID="CheckBox1"></asp:CheckBox>
                           </EditItemTemplate>
                           <ItemTemplate>
                              <asp:CheckBox ID="chkStatus" runat="server"           
                                       OnCheckedChanged="CheckBox1_CheckedChanged"
                                       Checked='<%# Convert.ToBoolean(Eval("paid")) %>'
                                       Text='<%# Eval("paid").ToString().Equals("True") ? " Betalt " : " Ikke betalt " %>' 
                                       AutoPostBack="true" />
                           </ItemTemplate>
                        </asp:TemplateField>

                        <asp:CommandField DeleteText="Slett" ShowDeleteButton="True"></asp:CommandField>

                     </Columns>
                   </asp:GridView>

                  </div>   
               </section>           
            </ContentTemplate>
         </asp:RoleGroup>
      </RoleGroups>
      </asp:LoginView>

   </div>

   <asp:SqlDataSource runat="server" ID="mcSignups" ConnectionString='<%$ ConnectionStrings:ConnectionString %>' 
      SelectCommand="SELECT excursions.excursion_name, excursions.excursion_date, sign_ups.sign_up_ID, sign_ups.excursion_ID, sign_ups.sign_up_user, sign_ups.registered_date, sign_ups.paid FROM excursions INNER JOIN sign_ups ON excursions.excursion_ID = sign_ups.excursion_ID ORDER BY sign_ups.sign_up_ID" 
      DeleteCommand="DELETE FROM sign_ups WHERE sign_up_ID = @sign_up_ID">
      <DeleteParameters>
         <asp:Parameter Name="sign_up_ID"></asp:Parameter>
      </DeleteParameters>
   </asp:SqlDataSource>

   <asp:SqlDataSource runat="server" ID="mcUserSignups" ConnectionString='<%$ ConnectionStrings:ConnectionString %>' 
      SelectCommand="SELECT excursions.excursion_name, excursions.excursion_date, sign_ups.sign_up_ID, sign_ups.excursion_ID, sign_ups.sign_up_user, sign_ups.registered_date, sign_ups.paid FROM excursions INNER JOIN sign_ups ON excursions.excursion_ID = sign_ups.excursion_ID ORDER BY sign_ups.sign_up_ID" 
      DeleteCommand="DELETE FROM sign_ups WHERE sign_up_ID = @sign_up_ID">
   </asp:SqlDataSource>

</asp:Content>

