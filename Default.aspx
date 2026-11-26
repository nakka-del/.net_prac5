
<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="Default.aspx.cs"
    Inherits="AcademicLeaveSystem.Default" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Academic Calendar and Leave Management</title>

    <style>
        body {
            font-family: Arial;
            margin: 30px;
        }

        .container {
            max-width: 850px;
            margin: auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 10px;
        }

        .section {
            margin: 20px 0;
            padding: 15px;
            border: 1px solid #ddd;
        }

        .field {
            margin: 12px 0;
        }

        .error {
            color: red;
        }

        .success {
            color: green;
        }
    </style>
</head>

<body>
<form id="form1" runat="server">

    <div class="container">
        <h2>Academic Calendar & Leave Management</h2>

        <asp:Label ID="lblWelcome" runat="server" />

        <div class="section">
            <h3>Academic Calendar</h3>

            <asp:Calendar ID="calAcademic" runat="server"
                SelectionMode="Day"
                OnSelectionChanged="calAcademic_SelectionChanged"
                BackColor="White"
                BorderColor="#3366CC"
                DayNameFormat="Shortest"
                Font-Names="Arial"
                Font-Size="10pt"
                ForeColor="#003399"
                Height="220px"
                Width="350px">

                <SelectedDayStyle BackColor="#009999"
                    Font-Bold="True" ForeColor="White" />

                <TodayDayStyle BackColor="#FFCC66"
                    ForeColor="Black" />

                <TitleStyle BackColor="#003399"
                    Font-Bold="True" ForeColor="White" />
            </asp:Calendar>

            <br />

            <asp:Label ID="lblSelectedDate" runat="server" />
        </div>

        <div class="section">
            <h3>Apply for Leave</h3>

            <div class="field">
                Student Name:
                <asp:TextBox ID="txtName" runat="server" />
                <asp:RequiredFieldValidator
                    ID="valName" runat="server"
                    ControlToValidate="txtName"
                    ErrorMessage="Enter your name."
                    CssClass="error" />
            </div>

            <div class="field">
                Leave Type:
                <asp:DropDownList ID="ddlLeaveType" runat="server">
                    <asp:ListItem Text="Select Leave Type" Value="" />
                    <asp:ListItem Text="Medical Leave" Value="Medical Leave" />
                    <asp:ListItem Text="Personal Leave" Value="Personal Leave" />
                    <asp:ListItem Text="Emergency Leave" Value="Emergency Leave" />
                </asp:DropDownList>

                <asp:RequiredFieldValidator
                    ID="valLeave" runat="server"
                    ControlToValidate="ddlLeaveType"
                    InitialValue=""
                    ErrorMessage="Select a leave type."
                    CssClass="error" />
            </div>

            <div class="field">
                From Date:
                <asp:TextBox ID="txtFromDate" runat="server"
                    TextMode="Date" />

                <asp:RequiredFieldValidator
                    ID="valFromDate" runat="server"
                    ControlToValidate="txtFromDate"
                    ErrorMessage="Select the start date."
                    CssClass="error" />
            </div>

            <div class="field">
                To Date:
                <asp:TextBox ID="txtToDate" runat="server"
                    TextMode="Date" />

                <asp:RequiredFieldValidator
                    ID="valToDate" runat="server"
                    ControlToValidate="txtToDate"
                    ErrorMessage="Select the end date."
                    CssClass="error" />
            </div>

            <div class="field">
                Reason:
                <asp:TextBox ID="txtReason" runat="server"
                    TextMode="MultiLine" Rows="3" />
            </div>

            <asp:Button ID="btnApply" runat="server"
                Text="Apply for Leave"
                OnClick="btnApply_Click" />

            <br /><br />

            <asp:ValidationSummary ID="ValidationSummary1"
                runat="server" CssClass="error" />

            <asp:Label ID="lblLeaveMessage" runat="server" />
        </div>

        <div class="section">
            <h3>Appearance Settings (Cookie)</h3>

            <asp:DropDownList ID="ddlColor" runat="server">
                <asp:ListItem Text="White" Value="white" />
                <asp:ListItem Text="Light Blue" Value="lightblue" />
                <asp:ListItem Text="Light Yellow" Value="lightyellow" />
                <asp:ListItem Text="Light Gray" Value="lightgray" />
            </asp:DropDownList>

            <asp:Button ID="btnColor" runat="server"
                Text="Save Background Colour"
                CausesValidation="false"
                OnClick="btnColor_Click" />
        </div>

        <div class="section">
            <h3>Leave Application Status</h3>

            <asp:Label ID="lblStatus" runat="server" />
        </div>

    </div>

</form>
</body>
</html>
