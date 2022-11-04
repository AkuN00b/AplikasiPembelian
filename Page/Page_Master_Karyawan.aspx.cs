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

        protected void btnKirim_Click(object sender, EventArgs e)
        {
            if (hiddenID.Text.Equals(""))
                createDataKaryawan();
            else
                updateDataKaryawan(hiddenID.Text);

            panelView.Visible = true;
            panelManipulasiData.Visible = false;
        }

        protected void createDataKaryawan()
        {
            try
            {
                DataTable dt = new DataTable();
                SqlConnection conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
                conn.Open();

                //SqlCommand command =
                //    new SqlCommand("insert into karyawan (npk, nama, provinsi)" +
                //    "values ('" + txtNPK.Text + "', '" + txtNama.Text + "', '" + ddProvinsi.SelectedItem.Text + "');", conn);

                //SqlDataAdapter adapter = new SqlDataAdapter();

                //adapter.InsertCommand = command;
                //adapter.InsertCommand.ExecuteNonQuery();

                SqlCommand command = new SqlCommand("sp_InsertKaryawan", conn);
                command.Parameters.AddWithValue("@nama", txtNamaKaryawan.Text);
                command.Parameters.AddWithValue("@alamat", txtAlamat.Text);
                command.Parameters.AddWithValue("@no_hp", txtNoHP.Text);
                command.CommandType = CommandType.StoredProcedure;
                dt.Load(command.ExecuteReader());

                conn.Close();

                loadData();
            }
            catch { }
        }

        protected void deleteDataKaryawan(string id)
        {
            try
            {
                DataTable dt = new DataTable();
                SqlConnection conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
                conn.Open();

                //SqlCommand command =
                //    new SqlCommand("delete from karyawan where id = " + id + ";", conn);

                //SqlDataAdapter adapter = new SqlDataAdapter();

                //adapter.DeleteCommand = command;
                //adapter.DeleteCommand.ExecuteNonQuery();

                SqlCommand command = new SqlCommand("sp_DeleteKaryawan", conn);
                command.Parameters.AddWithValue("@id", id);
                command.CommandType = CommandType.StoredProcedure;
                dt.Load(command.ExecuteReader());

                conn.Close();

                loadData();
            }
            catch { }
        }

        protected void updateDataKaryawan(string id)
        {
            try
            {
                DataTable dt = new DataTable();
                SqlConnection conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
                conn.Open();

                //SqlCommand command =
                //    new SqlCommand("update karyawan set npk = '" + txtNPK.Text + "', nama = '" + txtNama.Text + "', provinsi = '" + ddProvinsi.SelectedItem.Text + "' where id = " + id + ";", conn);

                //SqlDataAdapter adapter = new SqlDataAdapter();

                //adapter.UpdateCommand = command;
                //adapter.UpdateCommand.ExecuteNonQuery();

                SqlCommand command = new SqlCommand("sp_UpdateKaryawan", conn);
                command.Parameters.AddWithValue("@id", id);
                command.Parameters.AddWithValue("@nama", txtNamaKaryawan.Text);
                command.Parameters.AddWithValue("@alamat", txtAlamat.Text);
                command.Parameters.AddWithValue("@no_hp", txtNoHP.Text);
                command.CommandType = CommandType.StoredProcedure;
                dt.Load(command.ExecuteReader());

                conn.Close();

                loadData();
            }
            catch { }
        }

        protected void btnTambah_Click(object sender, EventArgs e)
        {

        }

        protected void clearForm()
        {
            hiddenID.Text = "";
            txtNamaKaryawan.Text = "";
            txtAlamat.Text = "";
            txtNoHP.Text = "";
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
                    deleteDataKaryawan(tempId);
                }
                else if (e.CommandName == "Ubah")
                {
                    hiddenID.Text = tempId;
                    panelView.Visible = false;
                    panelManipulasiData.Visible = true;
                    literalTitle.Text = "Form Ubah Data Karyawan";
                    btnKirim.Text = "Perbarui";

                    try
                    {
                        DataTable dt = new DataTable();

                        SqlConnection conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
                        conn.Open();

                        // SqlCommand command = new SqlCommand("select npk, nama, provinsi from karyawan where id = '" + tempId + "';", conn);

                        SqlCommand command = new SqlCommand("sp_getDataForUpdateKaryawan", conn);
                        command.Parameters.AddWithValue("@id", tempId);
                        command.CommandType = CommandType.StoredProcedure;

                        dt.Load(command.ExecuteReader());

                        txtNamaKaryawan.Text = dt.Rows[0][0].ToString();
                        txtAlamat.Text = dt.Rows[0][1].ToString();
                        txtNoHP.Text = dt.Rows[0][2].ToString();

                        conn.Close();
                    }
                    catch { }
                }
            }
        }

        protected void btnTambah_Click1(object sender, EventArgs e)
        {
            clearForm();
            panelView.Visible = false;
            panelManipulasiData.Visible = true;
            literalTitle.Text = "Form Tambah Data Karyawan";
            btnKirim.Text = "Tambah";
        }
    }
}