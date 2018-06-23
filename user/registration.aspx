<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="registration.aspx.cs" Inherits="user_registration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

   <section>
   <div class="registration-form">
      <div class="row">
         <h3 class="text-center">
            <asp:Label ID="excursionLabel" runat="server" Text="Label"></asp:Label>
         </h3>
      </div>
      <div class="row">
         <p class="text-center">
            <span>Kr </span><asp:Label ID="priceLabel" runat="server" Text="Label"></asp:Label>
         </p>
      </div>

   <div class="login-control row">
   <asp:DetailsView ID="DetailsView1" runat="server" 
      AutoGenerateRows="False"
      DataKeyNames="sign_up_ID" 
      DataSourceID="mcSign" 
      DefaultMode="Insert" 
      OnItemInserting="DetailsView1_ItemInserting"
      OnItemInserted="DetailsView1_ItemInserted" 
      GridLines="None"
      RowStyle-CssClass="form-group row margin-bottom" 
      OnDataBound="DetailsView1_DataBound" 
      OnItemUpdated="DetailsView1_ItemUpdated">
      <Fields>
         
         <asp:BoundField DataField="sign_up_ID" HeaderText="sign_up_ID" InsertVisible="False" Visible="false" ReadOnly="True" SortExpression="sign_up_ID" />
         <asp:BoundField DataField="excursion_ID" HeaderText="excursion_ID" SortExpression="excursion_ID" Visible="false" ReadOnly="true" ItemStyle-BorderStyle="None">
         
<ItemStyle BorderStyle="None"></ItemStyle>
         </asp:BoundField>
         
         <asp:TemplateField HeaderText="Brukernavn" ItemStyle-CssClass="col-sm-8 text-left" HeaderStyle-CssClass="col-sm-4 text-right" SortExpression="sign_up_user">
            <EditItemTemplate>
               <strong>
                     <asp:Label BorderStyle="None" ID="userLabel" runat="server" ReadOnly="true" Text='<%# Bind("sign_up_user") %>'></asp:Label>
                  </strong>
            </EditItemTemplate>
            <InsertItemTemplate>
                  <strong>
                     <asp:Label BorderStyle="None" ID="userLabel" runat="server" ReadOnly="true" Text='<%# Bind("sign_up_user") %>'></asp:Label>
                  </strong>
            </InsertItemTemplate>
            <ItemTemplate>
               <strong>
                     <asp:Label BorderStyle="None" ID="userLabel" runat="server" ReadOnly="true" Text='<%# Bind("sign_up_user") %>'></asp:Label>
                  </strong>
            </ItemTemplate>

<HeaderStyle CssClass="col-sm-4 text-right"></HeaderStyle>

<ItemStyle CssClass="col-sm-8 text-left"></ItemStyle>
         </asp:TemplateField>

         <asp:TemplateField HeaderText="Annen informasjon" ItemStyle-CssClass="col-sm-8 text-left" HeaderStyle-CssClass="col-sm-4 text-right" SortExpression="sign_up_text">
            <EditItemTemplate>
               <asp:TextBox ID="TextBox2" runat="server" CssClass="form-control otherInfo" TextMode="MultiLine" Text='<%# Bind("sign_up_text") %>'></asp:TextBox>
            </EditItemTemplate>
            <InsertItemTemplate>
               <asp:TextBox ID="otherInfo" runat="server" Rows="5" CssClass="form-control otherInfo" TextMode="MultiLine" Text='<%# Bind("sign_up_text") %>'></asp:TextBox>
            </InsertItemTemplate>
            <ItemTemplate>
               <asp:Label ID="Label2" runat="server" Text='<%# Bind("sign_up_text") %>'></asp:Label>
            </ItemTemplate>

<HeaderStyle CssClass="col-sm-4 text-right"></HeaderStyle>

<ItemStyle CssClass="col-sm-8 text-left"></ItemStyle>
         </asp:TemplateField>

         <asp:TemplateField HeaderText="Registrert den" InsertVisible="false" ItemStyle-CssClass="col-sm-8 text-left" HeaderStyle-CssClass="col-sm-4 text-right" SortExpression="registered_date">
            <EditItemTemplate>
                <strong>
                     <asp:Label BorderStyle="None" ID="regLabel" runat="server" ReadOnly="true" Text='<%# Bind("registered_date", "{0:f}") %>'></asp:Label>
                  </strong>
            </EditItemTemplate>
            <ItemTemplate>
               <strong>
                     <asp:Label BorderStyle="None" ID="regLabel" runat="server" ReadOnly="true" Text='<%# Bind("registered_date", "{0:f}") %>'></asp:Label>
                  </strong>
            </ItemTemplate>

<HeaderStyle CssClass="col-sm-4 text-right"></HeaderStyle>

<ItemStyle CssClass="col-sm-8 text-left"></ItemStyle>
         </asp:TemplateField>

          <asp:TemplateField InsertVisible="false" HeaderText="Betalt" ItemStyle-CssClass="col-sm-8 text-left" HeaderStyle-CssClass="col-sm-4 text-right" SortExpression="paid">
             <EditItemTemplate>
                <strong>  
                   <asp:Label BorderStyle="None" ID="paidLabel" runat="server" Text='<%# Bind("paid") %>'></asp:Label>
                </strong>
             </EditItemTemplate>
            <ItemTemplate>
               <strong>  
                  <asp:Label BorderStyle="None" ID="paidLabel" runat="server" Text='<%# Bind("paid") %>'></asp:Label>
               </strong>
            </ItemTemplate>

<HeaderStyle CssClass="col-sm-4 text-right"></HeaderStyle>

<ItemStyle CssClass="col-sm-8 text-left"></ItemStyle>
         </asp:TemplateField>

         <asp:TemplateField ShowHeader="False" HeaderStyle-CssClass="col-sm-12 row" >
            <InsertItemTemplate>
               <div class="col-sm-12 text-right">
                  <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-default" CausesValidation="True" CommandName="Insert" Text="Påmeld"></asp:LinkButton>
               </div>
            </InsertItemTemplate>
            <ItemTemplate>
               <div class="col-sm-12 text-right">
                  <asp:LinkButton ID="LinkButton2" runat="server" CssClass="btn btn-default" CausesValidation="True"  CommandName="Edit" Text="Endre"></asp:LinkButton>
               </div>
            </ItemTemplate>
            <EditItemTemplate>
               <div class="col-sm-12 text-right">
                  <asp:LinkButton ID="LinkButton3" runat="server" CssClass="btn btn-default" CausesValidation="True" CommandName="Update" Text="Lagre"></asp:LinkButton>
               </div>
            </EditItemTemplate>

<HeaderStyle CssClass="col-sm-12 row"></HeaderStyle>
         </asp:TemplateField>

          <asp:TemplateField ShowHeader="False">
            <InsertItemTemplate>
               
            </InsertItemTemplate>
         </asp:TemplateField>

      </Fields>
      <InsertRowStyle BorderStyle="None" />

<RowStyle CssClass="form-group row margin-bottom"></RowStyle>
   </asp:DetailsView>
</div>
      <asp:PlaceHolder ID="not_available" runat="server"></asp:PlaceHolder>

   <div runat="server" id="counter" class="row margin-top">
      <div class="col-sm-8 col-sm-offset-4 text-left">
         <p>
            <strong><asp:Label ID="countLabel" runat="server" Text=""></asp:Label></strong> registrerte påmeldinger til denne utflukten.
         </p>
        <p>
            <strong><asp:Label ID="availableSeats" runat="server" Text=""></asp:Label></strong>
            <span>ledige plasser igjen.</span>
        </p>
         
      </div>
   </div>


   <asp:SqlDataSource ID="mcSign" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
     SelectCommand="SELECT [sign_up_ID], [excursion_ID], [sign_up_user], [sign_up_text], [registered_date], CASE WHEN [paid] = 1 THEN 'Ja' ELSE 'Nei' END AS paid FROM [sign_ups] WHERE ([sign_up_ID] = @sign_up_ID)" 
     UpdateCommand="UPDATE [sign_ups] SET [sign_up_text] = @sign_up_text WHERE ([sign_up_ID] = @sign_up_ID)">
      <SelectParameters>
         <asp:QueryStringParameter Name="sign_up_ID" QueryStringField="sign_up_ID" Type="Int32" />
      </SelectParameters>
      <UpdateParameters>
         <asp:Parameter Name="sign_up_text" Type="String" />
         <asp:Parameter Name="sign_up_ID" Type="Int32" />
      </UpdateParameters>
   </asp:SqlDataSource>
            </div>
     </section>

</asp:Content>
