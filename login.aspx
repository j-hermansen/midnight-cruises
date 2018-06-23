<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

   <div class="row">
      <div class="col-md-4 col-md-offset-4 registration-control">
         <asp:LoginView ID="LoginView1" runat="server">
            <AnonymousTemplate>
               <section>
                  <asp:Login ID="Login1" runat="server" 
                     CreateUserText="Opprett en ny bruker" 
                     CreateUserUrl="signup.aspx"
                     FailureText="Din påloggingsforsøk var ikke vellykket. Prøv på nytt." 
                     LoginButtonText="Logg Inn" 
                     PasswordLabelText="Passord:" 
                     PasswordRequiredErrorMessage="Passord er påkrevd." 
                     RememberMeText="Husk meg til neste gang." 
                     TextLayout="TextOnTop" 
                     TitleText="Logg Inn" 
                     UserNameLabelText="Brukernavn:" 
                     UserNameRequiredErrorMessage="Brukernavn er påkrevd." 
                     CssClass="form-group">
                     <CheckBoxStyle Wrap="False" />
                     <LoginButtonStyle CssClass="btn btn-danger login-btn" />
                     <TextBoxStyle CssClass="form-control" />
                     <TitleTextStyle CssClass="login-header" />
                  </asp:Login>
               </section>
            </AnonymousTemplate>
            <LoggedInTemplate>
               <section>
                  <div class="row">
                     <p>Du er allerede logget inn.</p>
                  </div>
                  <div class="row">
                     <asp:LoginStatus ID="LoginStatus1" runat="server"
                        LoginText="Logg inn" 
                        LogoutText="Logg ut" 
                        CssClass="btn-link" />
                  </div>
               </section>
            </LoggedInTemplate>
         </asp:LoginView>
      </div>
   </div>

</asp:Content>

