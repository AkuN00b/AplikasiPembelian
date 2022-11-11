using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace AplikasiPembelian.Page
{
    public partial class Page_Pembelian : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                loadData();
                loadDDL();
                loadNoKwitansi();
                viewNamaBarang();
            }

            gridData.Width = Unit.Percentage(100);
        }

        protected void loadData()
        {
            DataTable dt = new DataTable();

            SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
            connection.Open();

            SqlCommand cmd = new SqlCommand("sp_getDataPembelian", connection);
            cmd.Parameters.AddWithValue("@query", txtCari.Text);

            cmd.CommandType = CommandType.StoredProcedure;
            dt.Load(cmd.ExecuteReader());

            gridData.DataSource = dt;
            gridData.DataBind();

            connection.Close();
        }

        protected void btnTambah_Click(object sender, EventArgs e)
        {
            clearForm();
            panelView.Visible = false;
            panelDetailData.Visible = false;
            panelTambahData.Visible = true;
            literalTambahData.Text = "Riwayat Pembelian - Tambah Baru";
        }

        protected void btnCari_Click(object sender, EventArgs e)
        {
            loadData();
        }

        protected void gridData_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gridData.PageIndex = e.NewPageIndex;
            loadData();
        }

        protected void gridData_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName != "Page")
            {
                string tempId = gridData.DataKeys[Convert.ToInt32(e.CommandArgument)].Value.ToString();

                if (e.CommandName == "Hapus")
                {
                    deleteDataPembelian(tempId);
                }
                else if (e.CommandName == "Detail")
                {
                    hiddenID.Text = tempId;
                    panelView.Visible = false;
                    panelTambahData.Visible = false;
                    panelDetailData.Visible = true;
                    literalTitle.Text = "Detail Pembelian";

                    try
                    {
                        DataTable dt = new DataTable();

                        SqlConnection conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
                        conn.Open();

                        // SqlCommand command = new SqlCommand("select npk, nama, provinsi from karyawan where id = '" + tempId + "';", conn);

                        SqlCommand command = new SqlCommand("sp_getDataForDetailPembelian", conn);
                        command.Parameters.AddWithValue("@id", tempId);
                        command.CommandType = CommandType.StoredProcedure;

                        dt.Load(command.ExecuteReader());

                        GridView1.DataSource = dt;
                        GridView1.DataBind();

                        conn.Close();
                    }
                    catch { }
                }
            }
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {

        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {

        }

        protected void deleteDataPembelian(string id)
        {
            try
            {
                DataTable dt = new DataTable();
                SqlConnection conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
                conn.Open();

                SqlCommand command = new SqlCommand("sp_DeletePembelian", conn);
                command.Parameters.AddWithValue("@id", id);
                command.CommandType = CommandType.StoredProcedure;
                dt.Load(command.ExecuteReader());

                conn.Close();

                loadData();
            }
            catch { }
        }

        protected void clearForm()
        {

        }

        public void loadDDL()
        {
            SqlConnection conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
            conn.Open();

            DDLNamaKaryawan.DataSource = "";
            DDLNamaKaryawan.Items.Clear();
            SqlCommand com = new SqlCommand();
            com.Connection = conn;
            com.CommandText = "sp_getDataKaryawan";
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@query", "");

            SqlDataAdapter adap = new SqlDataAdapter(com);
            DataTable dt = new DataTable();
            adap.Fill(dt);

            DDLNamaKaryawan.DataSource = dt;
            DDLNamaKaryawan.DataTextField = "nama";
            DDLNamaKaryawan.DataValueField = "id";
            DDLNamaKaryawan.DataBind();
            DDLNamaKaryawan.Items.Insert(0, new ListItem("-- Pilih Karyawan --", ""));
        }

        public void viewNamaBarang()
        {
            try
            {
                DataTable dt;
                SqlCommand command;
                SqlConnection conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
                conn.Open();

                dt = new DataTable();
                command = new SqlCommand("sp_getDataDetailTransaksi", conn);
                command.CommandType = CommandType.StoredProcedure;
                dt.Load(command.ExecuteReader());

                string str = "";
                string strr = "";

                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    str += "<h4 class='rincianBarang'>" + dt.Rows[i][1].ToString() + " x " + dt.Rows[i][3].ToString() + "  @" + dt.Rows[i][2].ToString() + "</h4>";
                    strr += "<h4 class='rincianBarang'>Rp. " + dt.Rows[i][4].ToString() + "</h4>";
                }

                loopNamaBarang.Text = str;
                loopTotalHargaBarang.Text = strr;

                conn.Close();

                // Total Harga
                conn.Open();

                dt = new DataTable();
                command = new SqlCommand("sp_getTotalFromDetailTransaksi", conn);
                command.CommandType = CommandType.StoredProcedure;
                dt.Load(command.ExecuteReader());

                str = "";

                str = "<h4 style='margin-top: 60px;'>Rp. " + dt.Rows[0][0].ToString() + "</h4>";

                totalHarga.Text = str;

                conn.Close();
            } catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.ToString() + "')</script>");
            }
        }

        public void loadNoKwitansi()
        {
            DateTime today = DateTime.Today;
            noKwitansi.Text += today.ToString("dd");
            noKwitansi.Text += today.ToString("MM");
            noKwitansi.Text += today.ToString("yyyy");
        }
    }
}