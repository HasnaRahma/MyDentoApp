using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;
using MySql.Data;
using MySql.Data.MySqlClient;
using System.Data;
using System.Data.SqlClient;

namespace GestionCabinetDentaire
{
    /// <summary>
    /// Logique d'interaction pour PopUpWindow.xaml
    /// </summary>
    public partial class PopUpPatient : Window
    {
        public MySql.Data.MySqlClient.MySqlConnection conn;
        public UserControl parent = null;
       
        public PopUpPatient( UserControl par)
        {
            InitializeComponent();
             ConnectDatabase();
            PatDatEnr.Text = DateTime.Now.ToShortDateString();
            parent = par;
           
           
           
        }
        private void ConnectDatabase()
        {


            string cn = "server=localhost; user id=root; password=''; database=cabinetdentaire; Convert Zero Datetime=True";
            conn = new MySql.Data.MySqlClient.MySqlConnection(cn);
            conn.Open();

        }
          protected T GetValue<T>(object obj)
        {
            if (typeof(DBNull) != obj.GetType())
            {
                return (T)Convert.ChangeType(obj, typeof(T));
            }
            return default(T);
        }

        protected T GetValue<T>(object obj, object defaultValue)
        {
            if (typeof(DBNull) != obj.GetType())
            {
                return (T)Convert.ChangeType(obj, typeof(T));
            }
            return (T)defaultValue;
        }

        private void Valider_Click(object sender, RoutedEventArgs e)
        {
            
            //conn.Open();
            //////Champs de la table Patient/////////////
            string nom = PatNom.Text;
            string prenom = PatPre.Text;
            string adr = PatAdr.Text;
            DateTime dateN;
            DateTime.TryParse(PatDatNai.Text,out dateN);
            int yearN;
            int.TryParse(dateN.Year.ToString(),out yearN);
            //= GetValue<DateTime>(PatDatNai.Text);
            // string dateN = PatDatNai.Text;
            string tel = PatTel.Text;
            string sexe = "";
            if (Femme.IsChecked == true)
            {
                sexe = "Femme";
            }
            if (Homme.IsChecked == true)
            {
                sexe = "Homme";
            }
            string profession = PatPro.Text;
            string desc = PatDes.Text;
            bool vide = false;
            if (((nom == "") || (prenom == "")))
            { vide = true; }
            if(vide == true)
            {
                string sMessageBoxText = "Veuillez au moins saisir le nom et le prénom du Patient !";
                string sCaption = "Alerte !";

                MessageBoxButton btnMessageBox = MessageBoxButton.OK;
                MessageBoxImage icnMessageBox = MessageBoxImage.Warning;

                MessageBoxResult rsltMessageBox = MessageBox.Show(sMessageBoxText, sCaption, btnMessageBox, icnMessageBox);
            }else
            {
                DateTime dateE = DateTime.Now;
                ///////////////////////////////////////////////
                string CmdString = "INSERT INTO patient (Pt_id, Pt_nom, Pt_prenom, Pt_adr, Pt_dateN, Pt_tel, Pt_sexe, Pt_profession, Pt_description, Pt_dateE, Pt_dateNYear) VALUES (NULL, @nom, @prenom , @adr, @dateN , @tel , @sexe ,  @profession , @desc , @dateE ,@year )";
                MySqlCommand cmd = new MySqlCommand(CmdString, conn);
                cmd.Parameters.AddWithValue("@nom", nom);
                cmd.Parameters.AddWithValue("@prenom", prenom);
                cmd.Parameters.AddWithValue("@adr", adr);
                cmd.Parameters.AddWithValue("@profession", profession);
                cmd.Parameters.AddWithValue("@desc", desc);
                cmd.Parameters.AddWithValue("@sexe", sexe);
                cmd.Parameters.AddWithValue("@dateN", dateN);
                int result = 0;
                int.TryParse(tel, out result);
                cmd.Parameters.AddWithValue("@tel", result);
                cmd.Parameters.AddWithValue("@year", yearN);
                cmd.Parameters.AddWithValue("@dateE", dateE);
                cmd.ExecuteNonQuery();
                cmd.Connection.Close();
                (parent as ListePatient).Refresh();
                this.Close();
                /* conn.Open();
                  CmdString = "SELECT Pt_id,Pt_nom,Pt_prenom,Pt_adr,Pt_description FROM Patient";
                  cmd = new MySqlCommand(CmdString, conn);
                  MySqlDataAdapter sda = new MySqlDataAdapter(cmd);
                  DataTable dt = new DataTable("Patient");
                  DataColumn Pt_id = new DataColumn("Pt_id");
                  Pt_id.DataType = System.Type.GetType("System.String");
                  dt.Columns.Add(Pt_id);
                  sda.Fill(dt);           
                  //grdPatient.ItemsSource = dt.DefaultView;
                Window Winvar = this;
                while (!(parent is Window))
                {

                   // Winvar = (Window)LogicalTreeHelper.GetParent(Winvar);

                    parent = Winvar;
                }*/
                //parent
            }


        }
    }
}
