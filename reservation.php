    <!-- header -->
    <?php
        session_start();
        require_once('db_connect.php');
        $id_utilisateur = $_SESSION['id_utilisateur'];
        $infosUtilisateur = get_bdd()->query("SELECT * FROM utilisateurs where id='$id_utilisateur'")->fetch();

        if(isset($_POST['choix'])){
          $infosReservation = preg_split("/;/", $_POST['choix']);
          //var_dump($infosReservation);
          function date_verif($d1)
{
            setlocale(LC_TIME, ['fr', 'fra', 'fr_FR']);

            $req = get_bdd()->query("SELECT dateFin FROM periode");
            while ($donnees = $req->fetch()){

                $tmstp1 = strtotime($d1);
                $tmstp2 = strtotime($donnees['dateFin']);
                
                $dfr1 = strftime('%Y-%m-%d', $tmstp1);
                $dfr2 = strftime('%Y-%m-%d', $tmstp2);
                
                if($tmstp1 <= $tmstp2){
                $DateDeb = get_bdd()->query("SELECT dateDeb FROM periode WHERE dateFin='$dfr2'")->fetch();

                return $DateDeb[0];
                }
            }
          }
          include('header.php');

          ?>
    <!-- header -->
    <section class="inner-page">
      <div class="slider-item py-5" style="background-image: url('img/slider-1.jpg');">
        
        <div class="container">
          <div class="row slider-text align-items-center justify-content-center text-center">
            <div class="col-md-7 col-sm-12 element-animate">
              <h1 class="text-white">Vous souhaitez reservé ?</h1>
            </div>
          </div>
        </div>

      </div>
    </section>
    
    <section class="section">
      <div class="container">
      <div class="text-center" style="margin-bottom:30px;">
          <h4>Liaison : <?php echo $infosReservation[0]; ?></h4>
          <h5> Traversée n°<?php echo $infosReservation[1]." le ".$infosReservation[2]. " à ".$infosReservation[3]; ?></h5>
      </div>

          <div class="col-md-12">
          <h5>Saisir les informations relatives à la réservation</h5>
            <form action="ajouter-reservation.php" method="POST">
            <input type="hidden" value="<?php echo $infosReservation[1]; ?>" name="num_traversee">
            <input type="hidden" value="<?php echo $id_utilisateur; ?>" name="id_utilisateurs">
            <input type="hidden" value="<?php echo "0"; ?>" name="quantite">
              <div class="row">
                <div class="col-md-5 form-group">
                  <label for="fname">Nom</label>
                  <h5><?php echo ucwords($infosUtilisateur['prenom']); ?></h5>
                </div>
                <div class="col-md-5 form-group">
                  <label for="lname">Prénom</label>
                  <h5><?php echo ucwords($infosUtilisateur['nom']); ?></h5>
                </div>
              </div>
              <div class="row">
                <div class="col-md-4 form-group">
                  <label for="adresse">Adresse</label>
                  <h5><?php echo ucwords($infosUtilisateur['adresse']); ?></h5>
                </div>
                <div class="col-md-3 form-group">
                  <label for="adresse">Code postal</label>
                  <h5><?php echo ucwords($infosUtilisateur['code_postal']); ?></h5>
                </div>
                <div class="col-md-3 form-group">
                  <label for="adresse">Ville</label>
                  <h5><?php echo ucwords($infosUtilisateur['ville']); ?></h5>
                </div>
              </div>
              <div class="row">
                <div class="col-md-10 form-group">

                <table class="table table-bordered" style="margin-top:20px;">
                  <thead>
                    <tr>
                      <th scope="col"></th>
                      <th scope="col">Tarif en €</th>
                      <th scope="col">Quantité</th>
                    </tr>
                  </thead>
                  <tbody>
                  <?Php
                  $dateDebut = date_verif($infosReservation[4]);
                  $date = $infosReservation[4];
                  $aa = $infosReservation[1];

                  $req = get_bdd()->query("SELECT dateFin FROM periode");


                  
               
                             // $placeReserveAdulte = get_bdd()->query('SELECT libelle, SUM(quantiteAdulte),SUM(quantiteJunior), SUM(quantiteEnfant), SUM(quantiteVoitureInf4m),SUM(quantiteVoitureInf5m),SUM(quantiteFourgon),SUM(quantiteCampingCar),SUM(quantiteCamion) FROM reservation WHERE num_traversee="'.$infosReservation[1].'"')->fetch();
                  $idLiaison = get_bdd()->query("SELECT code_liaison FROM traversee WHERE num_traversee = '$aa'")->fetch();

                  $req2 = get_bdd()->query("SELECT * FROM tarifer INNER JOIN traversee where traversee.code_liaison = tarifer.code_liaison AND dateDeb='$dateDebut' AND tarifer.code_liaison='$idLiaison[0]' AND date='$date'");
                  $nb = 0;
                  while ($donnees1 = $req2->fetch()){
                    $nb++;
                              //var_dump($req2);
                                
                                //$req3 = get_bdd()->query("SELECT * FROM type WHERE num_type='$aa' ")->fetch();
                                //var_dump($req3);

                                
?>
                  <tr>
                      <td><?php //echo $donnees1['libelle']; ?> </td>
                      <td><?php echo $donnees1['tarif']; ?></td>
                      <td>
                        <select class="form-control" id="" name="<?php echo $nb; ?>">
                          <option value="<?php echo "0;".$donnees1['tarif']; ?>" active>0</option>
                          <?php
                          for($i = 1;$i <= 50;$i++){
                            ?>
                          <option value="<?php echo $i.";".$donnees1['tarif']; ?>"><?php echo $i; ?></option>  
                          <?php
                          }
                          ?>
                          

                        </select>
                      </td>
                    </tr>
<?php 
                              }
                  ?>
                  
                  </tbody>
                </table>
                </div>
              </div>
              </div>
              <div class="row">
                <div class="col-md-4 form-group">
                <button type="submit" name="reserver" class="btn btn-primary btn-lg btn-block">Enregistrer la réservation</button>
                </div>
              </div>
            </form>
          </div>
        </div>
      </div>
    </section>
    

    <section class="container cta-overlap">
      <div class="text d-flex">
        <h2 class="h3">Vous avez une question ?</h2>
        <div class="ml-auto btn-wrap">
          <a href="get-quote.html" class="btn-cta btn btn-outline-white">Nous contacter</a>
        </div>
      </div>
    </section>
    <!-- END section -->

    <!-- footer -->
    <?php include('footer.php');?>
    <!-- footer -->


    <!-- loader -->
    <div id="loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#f4b214"/></svg></div>

    <script src="js/jquery-3.2.1.min.js"></script>
    <script src="js/popper.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/owl.carousel.min.js"></script>
    <script src="js/jquery.waypoints.min.js"></script>
    <script src="js/main.js"></script>
  </body>
</html>


          <?php
        }else{
          //header('location:liaisons.php');
        }
    ?>
