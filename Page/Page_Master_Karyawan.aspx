<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/Header.Master" AutoEventWireup="true" CodeBehind="Page_Master_Karyawan.aspx.cs" Inherits="AplikasiPembelian.Page_Master_Karyawan" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Panel runat="server" ID="panelView">
        <h2>Master Karyawan</h2>
        <hr />

        <asp:Button Text="+" ID="btnTambah" OnClick="btnTambah_Click1" runat="server" />
        <asp:TextBox runat="server" ID="txtCari" placeholder="Pencarian" />
        <asp:Button Text="Cari" ID="btnCari" OnClick="btnCari_Click" runat="server" />

        <br />
        <br />

        <asp:GridView runat="server" ID="gridData" AutoGenerateColumns="false" EmptyDataText="Tidak ada data"
            ShowHeader="true" ShowHeaderWhenEmpty="true" PageSize="5" AllowPaging="true" AllowSorting="false"
            DataKeyNames="id" OnPageIndexChanging="gridData_PageIndexChanging" OnRowCommand="gridData_RowCommand">

            <PagerSettings Mode="NumericFirstLast" FirstPageText="<<" LastPageText=">>" />

            <Columns>
                <asp:BoundField DataField="rownum" HeaderText="No" ItemStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="nama" HeaderText="Nama Karyawan" ItemStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="alamat" HeaderText="Alamat" ItemStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="no_hp" HeaderText="Nomor HP" ItemStyle-HorizontalAlign="Center" />
                <asp:TemplateField HeaderText="Aksi" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:LinkButton Text="[Ubah]" ID="btnUbah" CommandName="Ubah" runat="server" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'></asp:LinkButton>&nbsp;
                        <asp:LinkButton Text="[Hapus]" ID="btnHapus" CommandName="Hapus" runat="server" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </asp:Panel>

    <asp:Panel runat="server" ID="panelManipulasiData" Visible="false">
        <h2>
            <asp:Literal runat="server" ID="literalTitle"></asp:Literal>
        </h2>
        <asp:TextBox runat="server" ID="hiddenID" Visible="false"></asp:TextBox>

        <label>Nama Karyawan</label>
        <br />
        <asp:TextBox runat="server" ID="txtNamaKaryawan"></asp:TextBox>
        <br />
        <br />

        <label>Alamat</label>
        <br />
        <asp:TextBox runat="server" ID="txtAlamat"></asp:TextBox>
        <br />
        <br />

        <label>No HP</label>
        <br />
        <asp:TextBox runat="server" ID="txtNoHP" MaxLength="13"></asp:TextBox>
        <br />
        <br />

        <asp:Button runat="server" ID="btnKirim" OnClick="btnKirim_Click" />
    </asp:Panel>
</asp:Content>
