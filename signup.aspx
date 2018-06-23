<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="signup.aspx.cs" Inherits="signup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

   <section>

      <div class="registration-form">
         <asp:CreateUserWizard ID="CreateUserWizard1" runat="server"
            CompleteSuccessText="Kontoen er opprettet." 
            ConfirmPasswordCompareErrorMessage="Passordet og Bekreftelsespassordet må samsvare." 
            ConfirmPasswordLabelText="Bekreft passordet:" 
            ConfirmPasswordRequiredErrorMessage="Bekreft passord er nødvendig." 
            ContinueButtonText="Fortsett"
            ContinueDestinationPageUrl="~/default.aspx"
            CreateUserButtonText="Opprett bruker" 
            DuplicateEmailErrorMessage="E-postadressen du angav er allerede i bruk. Angi en annen e-postadresse." 
            DuplicateUserNameErrorMessage="Angi et annet brukernavn." 
            EmailLabelText="E-post:" 
            EmailRegularExpressionErrorMessage="Angi en annen e-post." 
            EmailRequiredErrorMessage="E-post er påkrevd." 
            FinishCompleteButtonText="Fullfør" 
            InvalidEmailErrorMessage="Skriv inn en gyldig epostadresse." 
            InvalidPasswordErrorMessage="Minimal passordlengde: {0}. kreves ikke-alfanumeriske tegn: {1}." 
            PasswordLabelText="Passord:" 
            PasswordRegularExpressionErrorMessage="Skriv inn et annet passord." 
            PasswordRequiredErrorMessage="Passord kreves."
            UnknownErrorMessage="Kontoen ble ikke opprettet. Prøv på nytt." 
            UserNameLabelText="Brukernavn:" 
            UserNameRequiredErrorMessage="Brukernavnet er påkrevd." 
            TitleTextStyle-CssClass="create_user_title">
            <CreateUserButtonStyle CssClass="btn btn-danger" />
            <WizardSteps>
               <asp:CreateUserWizardStep ID="CreateUserWizardStep1" runat="server" Title="Opprett din nye bruker.">
                  <ContentTemplate>
                     <table>
                        <tr class="row create_user_title">
                           <td align="center" colspan="2" >Opprett din nye bruker.</td>
                        </tr>
                        <tr class="form-group row">
                           <td align="right" class="col-md-2 control-label">
                              <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">Brukernavn:</asp:Label>
                           </td>
                           <td class="col-md-10">
                              <asp:TextBox ID="UserName" runat="server" CssClass="form-control"></asp:TextBox>
                              <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName" ErrorMessage="Brukernavnet er påkrevd." ToolTip="Brukernavnet er påkrevd." ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                           </td>
                        </tr>
                        <tr class="form-group row">
                           <td align="right" class="col-sm-2 control-label">
                              <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password">Passord:</asp:Label>
                           </td>
                           <td class="col-sm-10">
                              <asp:TextBox ID="Password" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                              <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password" ErrorMessage="Passord kreves." ToolTip="Passord kreves." ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                           </td>
                        </tr>
                        <tr class="form-group row">
                           <td align="right" class="col-sm-2 control-label">
                              <asp:Label ID="ConfirmPasswordLabel" runat="server" AssociatedControlID="ConfirmPassword">Bekreft passordet:</asp:Label>
                           </td>
                           <td class="col-sm-10">
                              <asp:TextBox ID="ConfirmPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                              <asp:RequiredFieldValidator ID="ConfirmPasswordRequired" runat="server" ControlToValidate="ConfirmPassword" ErrorMessage="Bekreft passord er nødvendig." ToolTip="Bekreft passord er nødvendig." ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                           </td>
                        </tr>
                        <tr class="form-group row">
                           <td align="right" class="col-sm-2 control-label">
                              <asp:Label ID="EmailLabel" runat="server" AssociatedControlID="Email">E-post:</asp:Label>
                           </td>
                           <td class="col-sm-10">
                              <asp:TextBox ID="Email" runat="server" CssClass="form-control"></asp:TextBox>
                              <asp:RequiredFieldValidator ID="EmailRequired" runat="server" ControlToValidate="Email" ErrorMessage="E-post er påkrevd." ToolTip="E-post er påkrevd." ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                           </td>
                        </tr>
                        <tr class="form-group row">
                           <td align="center" colspan="2">
                              <asp:CompareValidator ID="PasswordCompare" runat="server" ControlToCompare="Password" ControlToValidate="ConfirmPassword" Display="Dynamic" ErrorMessage="Passordet og Bekreftelsespassordet må samsvare." ValidationGroup="CreateUserWizard1"></asp:CompareValidator>
                           </td>
                        </tr>
                        <tr class="form-group row">
                           <td align="center" colspan="2" style="color:Red;">
                              <asp:Literal ID="ErrorMessage" runat="server" EnableViewState="False"></asp:Literal>
                           </td>
                        </tr>
                     </table>
                  </ContentTemplate>
               </asp:CreateUserWizardStep>
               <asp:CompleteWizardStep ID="CompleteWizardStep1" runat="server" Title="">
                  <ContentTemplate>
                     <table>
                        <tr>
                           <td class="alert alert-success">Kontoen er opprettet.</td>
                        </tr>
                        <tr>
                           <td align="right">
                              <asp:Button ID="ContinueButton" CssClass="btn btn-default" runat="server" CausesValidation="False" CommandName="Continue" Text="Fortsett" ValidationGroup="CreateUserWizard1" />
                           </td>
                        </tr>
                     </table>
                  </ContentTemplate>
               </asp:CompleteWizardStep>
            </WizardSteps>
         </asp:CreateUserWizard>
      </div>

   </section>

</asp:Content>

