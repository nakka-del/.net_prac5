
using System;
using System.Drawing;
using System.Web;
using System.Web.UI;

namespace AcademicLeaveSystem
{
    public partial class Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Session stores the student name
                if (Session["StudentName"] == null)
                    Session["StudentName"] = "Student";

                lblWelcome.Text =
                    "Welcome, " +
                    Server.HtmlEncode(Session["StudentName"].ToString());

                // Read the background colour cookie
                HttpCookie colorCookie =
                    Request.Cookies["PreferredColor"];

                if (colorCookie != null)
                {
                    string color = colorCookie.Value;

                    if (IsAllowedColor(color))
                    {
                        ddlColor.SelectedValue = color;
                        ApplyBackground(color);
                    }
                }

                lblStatus.Text = "No leave application submitted yet.";
            }

            // Restore status from session after postbacks
            if (Session["LeaveStatus"] != null)
                lblStatus.Text =
                    Server.HtmlEncode(Session["LeaveStatus"].ToString());
        }

        protected void calAcademic_SelectionChanged(
            object sender, EventArgs e)
        {
            lblSelectedDate.Text =
                "Selected Date: " +
                calAcademic.SelectedDate.ToString("dd-MM-yyyy");
        }

        protected void btnApply_Click(object sender, EventArgs e)
        {
            Page.Validate();

            if (!Page.IsValid)
                return;

            DateTime fromDate;
            DateTime toDate;

            if (!DateTime.TryParse(txtFromDate.Text, out fromDate) ||
                !DateTime.TryParse(txtToDate.Text, out toDate))
            {
                lblLeaveMessage.CssClass = "error";
                lblLeaveMessage.Text = "Please enter valid dates.";
                return;
            }

            if (toDate < fromDate)
            {
                lblLeaveMessage.CssClass = "error";
                lblLeaveMessage.Text =
                    "End date cannot be before start date.";
                return;
            }

            // Store student name in Session
            Session["StudentName"] = txtName.Text.Trim();

            string status =
                "Pending - " + ddlLeaveType.SelectedValue +
                " (" + fromDate.ToString("dd-MM-yyyy") +
                " to " + toDate.ToString("dd-MM-yyyy") + ")";

            // Store leave status in Session
            Session["LeaveStatus"] = status;

            lblWelcome.Text =
                "Welcome, " +
                Server.HtmlEncode(txtName.Text.Trim());

            lblLeaveMessage.CssClass = "success";
            lblLeaveMessage.Text =
                "Leave application submitted successfully.";

            lblStatus.Text = Server.HtmlEncode(status);
        }

        protected void btnColor_Click(object sender, EventArgs e)
        {
            string color = ddlColor.SelectedValue;

            if (!IsAllowedColor(color))
                return;

            HttpCookie cookie =
                new HttpCookie("PreferredColor", color);

            cookie.Expires = DateTime.Now.AddDays(30);
            cookie.HttpOnly = true;

            if (Request.IsSecureConnection)
                cookie.Secure = true;

            Response.Cookies.Add(cookie);

            ApplyBackground(color);
        }

        private bool IsAllowedColor(string color)
        {
            return color == "white" ||
                   color == "lightblue" ||
                   color == "lightyellow" ||
                   color == "lightgray";
        }

        private void ApplyBackground(string color)
        {
            if (IsAllowedColor(color))
                form1.Style["background-color"] = color;
        }
    }
}
