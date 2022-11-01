using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace AplikasiPembelian
{
    public partial class Page_Master_Karyawan : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                loadData();
            }

            gridData.Width = Unit.Percentage(100);
        }

        protected void loadData()
        {
            DataTable dt = new DataTable();

            SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
            connection.Open();

            SqlCommand cmd = new SqlCommand("sp_getDataKaryawan", connection);
            cmd.Parameters.AddWithValue("@query", txtCari.Text);
            cmd.CommandType = CommandType.StoredProcedure;
            dt.Load(cmd.ExecuteReader());

            gridData.DataSource = dt;
            gridData.DataBind();

            connection.Close();
        }

        protected void btnCari_Click(object sender, EventArgs e)
        {
            loadData();
        }
    }
}