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
namespace GestionCabinetDentaire.PopUps
{
    /// <summary>
    /// Logique d'interaction pour PopUpOdf.xaml
    /// </summary>
    public partial class PopUpOdf : Window
    {
        public MySql.Data.MySqlClient.MySqlConnection conn;
        public UserControl parent = null;
        public PopUpOdf(UserControl par)
        {
            InitializeComponent();
            ConnectDatabase();
            conn.Open();
            OdfDatEnr.Text = DateTime.Now.ToShortDateString();
            parent = par;
            string CmdString = "Select Ut_id, Ut_nom , Ut_prenom from Utilisateur where Medecin = " + 1;
            MySqlCommand cmd = new MySqlCommand(CmdString, conn);
            MySqlDataReader reader = cmd.ExecuteReader();
            string docteur;
            while (reader.Read())
            {
                docteur = reader["Ut_id"].ToString() + ' ' + reader["Ut_nom"].ToString() + ' ' + reader["Ut_prenom"].ToString();
                OdfMedecin.Items.Add(docteur);
            }
            cmd.Connection.Close();
            conn.Close();
            ConnectDatabase();
            conn.Open();
            CmdString = "Select Pt_id, Pt_nom , Pt_prenom from Patient ";
            cmd = new MySqlCommand(CmdString, conn);
            reader = cmd.ExecuteReader();
            string patientC;
            while (reader.Read())
            {
                patientC = reader["Pt_id"].ToString() + ' ' + reader["Pt_nom"].ToString() + ' ' + reader["Pt_prenom"].ToString();
                PrPatient.Items.Add(patientC);
            }
            conn.Close();
        }
        private void ConnectDatabase()
        {
            string cn = "server=localhost; user id=root; password=''; database=cabinetdentaire; Convert Zero Datetime=True";
            conn = new MySql.Data.MySqlClient.MySqlConnection(cn);


        }
        private void Valider_Click(object sender, RoutedEventArgs e)
        {
            conn.Open();

            string diagnostic = OdfDiagnostic.Text;
            string plan = OdfPlan.Text;
            //string acte = SoActe.Text;
            int versement;
            int.TryParse(OdfVersement.Text, out versement);
            int cout;
            int.TryParse(OdfCout.Text, out cout);
            

            DateTime dateE = DateTime.Now;
            ///////////////////////////////////////////////
            if ((OdfMedecin.SelectedItem != null) && (PrPatient.SelectedItem != null))
            {
                string docteur = OdfMedecin.SelectedItem.ToString();
                string[] tokens = docteur.Split(' ');
                int medid = 0;
                int.TryParse(tokens[0], out medid);
                string patients = PrPatient.SelectedItem.ToString();
                string[] tokens2 = patients.Split(' ');
                int patient = 0;
                int.TryParse(tokens2[0], out patient);
                string CmdString = "INSERT INTO Odf (Odf_id, Odf_diagnostic, Doc_id , Odf_coutTotal , Odf_verset , Odf_planTravail, Odf_date , Pt_id ) VALUES (NULL, @diagnostic, @docid, @cout , @versement , @plan , @dateE , @patId )";
                MySqlCommand cmd = new MySqlCommand(CmdString, conn);
                cmd.Parameters.AddWithValue("@diagnostic", diagnostic);
                cmd.Parameters.AddWithValue("@plan", plan);               
                cmd.Parameters.AddWithValue("@versement", versement);
                cmd.Parameters.AddWithValue("@cout", cout);
                cmd.Parameters.AddWithValue("@dateE", dateE);        
                cmd.Parameters.AddWithValue("@patId", patient);
                cmd.Parameters.AddWithValue("@docid", medid);
                cmd.ExecuteNonQuery();
                cmd.Connection.Close();
                conn.Close();
                (parent as ListeOdf).Refresh();

                this.Close();
            }
            else
            {


                string sMessageBoxText = "veuillez  choisir au moins un Médecin et un patient !";
                string sCaption = "Alerte";

                MessageBoxButton btnMessageBox = MessageBoxButton.OK;
                MessageBoxImage icnMessageBox = MessageBoxImage.Question;

                MessageBoxResult rsltMessageBox = MessageBox.Show(sMessageBoxText, sCaption, btnMessageBox, icnMessageBox);
                conn.Close();
            }

            conn.Close();

        }
    }
}
