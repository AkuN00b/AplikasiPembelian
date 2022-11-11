<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/Header.Master" AutoEventWireup="true" CodeBehind="Page_Pembelian.aspx.cs" Inherits="AplikasiPembelian.Page.Page_Pembelian" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="padding-left: 15px; padding-right: 15px;">
        <asp:Panel runat="server" ID="panelView">
            <h2>Pembelian</h2>
            <hr />

            <asp:Button Text="+" ID="btnTambah" OnClick="btnTambah_Click" runat="server" />
            <asp:TextBox runat="server" ID="txtCari" placeholder="Pencarian" />
            <asp:Button Text="Cari" ID="btnCari" OnClick="btnCari_Click" runat="server" />

            <br />
            <br />

            <asp:Literal id="noKwitansi" runat="server" />

            <asp:GridView runat="server" ID="gridData" AutoGenerateColumns="false" EmptyDataText="Tidak ada data"
                ShowHeader="true" ShowHeaderWhenEmpty="true" PageSize="5" AllowPaging="true" AllowSorting="false"
                DataKeyNames="id" OnPageIndexChanging="gridData_PageIndexChanging" OnRowCommand="gridData_RowCommand">

                <PagerSettings Mode="NumericFirstLast" FirstPageText="<<" LastPageText=">>" />

                <Columns>
                    <asp:BoundField DataField="rownum" HeaderText="No" ItemStyle-HorizontalAlign="Center" />
                    <asp:BoundField DataField="kwitansi" HeaderText="No Kwitansi" ItemStyle-HorizontalAlign="Center" />
                    <asp:BoundField DataField="namaKaryawan" HeaderText="Nama Karyawan" ItemStyle-HorizontalAlign="Center" />
                    <asp:BoundField DataField="jumlahBarang" HeaderText="Jumlah Barang" ItemStyle-HorizontalAlign="Center" />
                    <asp:BoundField DataField="totalHarga" HeaderText="Total Harga" ItemStyle-HorizontalAlign="Center" />
                    <asp:TemplateField HeaderText="Aksi" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:LinkButton Text="[Detail]" ID="btnDetail" CommandName="Detail" runat="server" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'></asp:LinkButton>&nbsp;
                        <asp:LinkButton Text="[Hapus]" ID="btnHapus" CommandName="Hapus" runat="server" CommandArgument='<%# DataBinder.Eval(Container, "RowIndex") %>'></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </asp:Panel>

        <asp:Panel runat="server" ID="panelTambahData" Visible="false">
            <h2>
                <asp:Literal ID="literalTambahData" runat="server" />
            </h2>
            <hr />

            <table border="0" class="table2">
                <tr>
                    <td width="50%">
                        <table border="1" class="table1" style="border: 3px solid black;">
                            <tr class="rowTable">
                                <td style="padding-left: 20px;" class="sisiKanan">
                                    <h4 align="left">Nama Barang</h4>
                                    <asp:TextBox runat="server" ID="namaBarang" CssClass="inputName" />
                                </td>
                            </tr>

                            <tr class="rowTable">
                                <td style="padding-left: 20px;" class="sisiKanan">
                                    <h4 align="left">Harga</h4>
                                    <asp:TextBox runat="server" ID="hargaBarang" CssClass="inputName" />
                                </td>
                            </tr>

                            <tr class="rowTable">
                                <td style="padding-left: 20px;" class="sisiKanan">
                                    <h4 align="left">Quantity</h4>
                                    <asp:TextBox runat="server" ID="quantity" CssClass="inputName" />
                                </td>
                            </tr>

                            <tr class="rowTable" align="right">
                                <td style="padding-left: 20px; padding-right: 20px;" class="sisiKanan">
                                    <asp:Button Text="+" CssClass="buttonKirim" runat="server" />
                                </td>
                            </tr>
                        </table>
                    </td>

                    <td width="50%" style="vertical-align: top; margin-top: -20px;">
                        <table border="0" class="table3">
                            <tr class="rowTable">
                                <td width="50%" style="padding-left: 20px;" class="sisiKanan">
                                    <h2 align="left">Nama Karyawan</h2>
                                    <asp:DropDownList ID="DDLNamaKaryawan" runat="server" CssClass="inputSelect"></asp:DropDownList>
                                </td>
                            </tr>
                            <tr class="rowTable">
                                <td width="50%" style="padding-left: 20px;" class="sisiKanan">
                                    <h2 align="left" style="margin-bottom: -6px;">Rincian Barang</h2>
                                    <table class="table3" border="0">
                                        <tr>
                                            <td>
                                                <asp:Literal runat="server" ID="loopNamaBarang" />
                                            </td>
                                            <td align="right">
                                                <asp:Literal runat="server" ID="loopTotalHargaBarang" />
                                            </td>
                                        </tr>

                                        <tr>
                                            <td></td>
                                            <td></td>
                                        </tr>

                                        <tr>
                                            <td></td>
                                            <td></td>
                                        </tr>

                                        <tr>
                                            <td>
                                                <h4 style="margin-top: 60px;">TOTAL HARGA</h4>
                                            </td>
                                            <td align="right">
                                                <asp:Literal id="totalHarga" runat="server" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>

                <tr>
                    <td>
                        <button class="buttonKonfirmasi">Batal</button>
                        <button class="buttonKonfirmasi">Simpan</button>
                    </td>
                    <td></td>
                </tr>
            </table>
        </asp:Panel>

        <asp:Panel runat="server" ID="panelDetailData" Visible="false">
            <h2>
                <asp:Literal runat="server" ID="literalTitle"></asp:Literal>
            </h2>
            <hr />
            <asp:TextBox runat="server" ID="hiddenID" Visible="false"></asp:TextBox>

            <asp:GridView runat="server" ID="GridView1" AutoGenerateColumns="false" EmptyDataText="Tidak ada data"
                ShowHeader="true" ShowHeaderWhenEmpty="true" AllowPaging="false" AllowSorting="false"
                DataKeyNames="id" OnPageIndexChanging="GridView1_PageIndexChanging" OnRowCommand="GridView1_RowCommand">

                <PagerSettings Mode="NumericFirstLast" FirstPageText="<<" LastPageText=">>" />

                <Columns>
                    <asp:BoundField DataField="rownum" HeaderText="No" ItemStyle-HorizontalAlign="Center" />
                    <asp:BoundField DataField="nama_barang" HeaderText="Nama Barang" ItemStyle-HorizontalAlign="Center" />
                    <asp:BoundField DataField="harga" HeaderText="Harga" ItemStyle-HorizontalAlign="Center" />
                    <asp:BoundField DataField="quantity" HeaderText="Kuantitas" ItemStyle-HorizontalAlign="Center" />
                </Columns>
            </asp:GridView>
        </asp:Panel>
    </div>
</asp:Content>
