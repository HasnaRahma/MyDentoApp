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

namespace GestionCabinetDentaire.PopUps
{
    /// <summary>
    /// Logique d'interaction pour PopUpControle.xaml
    /// </summary>
    public partial class PopUpControle : Window
    {
        public MySql.Data.MySqlClient.MySqlConnection conn;
        public UserControl parent = null;
        private int OdfId; 

        public PopUpControle(UserControl par, int odf)
        {
            InitializeComponent();
            ConnectDatabase();
            CoDatEnr.Text = DateTime.Now.ToShortDateString();
            parent = par;
            OdfId = odf;
            string CmdString = "Select Ut_id, Ut_nom , Ut_prenom from Utilisateur where Medecin = " + 1;
            MySqlCommand cmd = new MySqlCommand(CmdString, conn);
            MySqlDataReader reader = cmd.ExecuteReader();
            string docteur;
            while (reader.Read())
            {
                docteur = reader["Ut_id"].ToString() + reader["Ut_nom"].ToString() + reader["Ut_prenom"].ToString();
                CoMedecin.Items.Add(docteur);
            }
            cmd.Connection.Close();
            conn.Close();
        }
        private void ConnectDatabase()
        {


            string cn = "server=localhost; user id=root; password=''; database=cabinetdentaire; Convert Zero Datetime=True";
            conn = new MySql.Data.MySqlClient.MySqlConnection(cn);
            conn.Open();

        }
        private void Valider_Click(object sender, RoutedEventArgs e)
        {
            conn.Open();

            string description = CoDescription.Text;
            int versement;
            int.TryParse(CoVersement.Text, out versement);
            string traitement = CoTraitement.Text;
            DateTime dateE = DateTime.Now;




            ///////////////////////////////////////////////
            if (CoMedecin.SelectedItem != null )
            {
            string docteur = CoMedecin.SelectedItem.ToString();
            string[] tokens = docteur.Split(' ');


            string CmdString = "Select Ut_id from Utilisateur where Ut_id = @id ";
            MySqlCommand cmd = new MySqlCommand(CmdString, conn);
            cmd.Parameters.AddWithValue("@id",tokens[0]);
            //cmd.Parameters.AddWithValue("@prenom",tokens[1]);
            MySqlDataReader reader = cmd.ExecuteReader();
            int medid = 0 ;
            while (reader.Read())
            {

                int.TryParse(reader["Ut_id"].ToString() , out medid);
                
                }   
            cmd.Connection.Close();

                
                conn.Open();
                CmdString = "INSERT INTO Controles (Co_id, Co_date, doc_id , Co_versement , Co_description , Odf_id, Co_traitement ) VALUES (NULL, @dateE, @docid, @versement , @description , @odfid , @traitement  )";
                cmd = new MySqlCommand(CmdString, conn);
                cmd.Parameters.AddWithValue("@description", description);
                cmd.Parameters.AddWithValue("@versement", versement);
                cmd.Parameters.AddWithValue("@traitement", traitement);
                cmd.Parameters.AddWithValue("@dateE", dateE);
                cmd.Parameters.AddWithValue("@odfid", OdfId);
                cmd.Parameters.AddWithValue("@docid", medid);
                cmd.ExecuteNonQuery();
                cmd.Connection.Close();
                (parent as PatientOdf).Refresh();
                conn.Close();
                this.Close();
            }
            else
            {
               
                
                    string sMessageBoxText = "veuillez  choisir  un Médecin !";
                    string sCaption = "Alerte";

                    MessageBoxButton btnMessageBox = MessageBoxButton.OK;
                    MessageBoxImage icnMessageBox = MessageBoxImage.Question;

                    MessageBoxResult rsltMessageBox = MessageBox.Show(sMessageBoxText, sCaption, btnMessageBox, icnMessageBox);
                conn.Close();
            }
            

          
        }
    }
    
}
