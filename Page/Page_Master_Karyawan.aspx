<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/Header.Master" AutoEventWireup="true" CodeBehind="Page_Master_Karyawan.aspx.cs" Inherits="AplikasiPembelian.Page_Master_Karyawan" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2>Master Karyawan</h2>
    <hr />

    <asp:Button Text="+" ID="btnTambah" runat="server" />
    <asp:TextBox runat="server" ID="txtCari" placeholder="Pencarian" />
    <asp:Button Text="Cari" ID="btnCari" OnClick="btnCari_Click" runat="server" />

    <br />
    <br />

    <asp:GridView runat="server" ID="gridData" AutoGenerateColumns="false" EmptyDataText="Tidak ada data"
        ShowHeader="true" ShowHeaderWhenEmpty="true" PageSize="5" AllowPaging="true" AllowSorting="false"
        DataKeyNames="id">
        <PagerSettings Mode="NumericFirstLast" FirstPageText="<<" LastPageText=">>" />

        <Columns>
            <asp:BoundField DataField="rownum" HeaderText="No" />
            <asp:BoundField DataField="nama" HeaderText="Nama Karyawan" />
            <asp:BoundField DataField="alamat" HeaderText="Alamat" />
            <asp:BoundField DataField="no_hp" HeaderText="Nomor HP" />
            <asp:TemplateField HeaderText="Aksi">
                <ItemTemplate>
                    <asp:Button Text="[Ubah]" ID="btnUbah" CommandName="Ubah" runat="server" />
                    <asp:Button Text="[Hapus]" ID="btnHapus" CommandName="Hapus" runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>
