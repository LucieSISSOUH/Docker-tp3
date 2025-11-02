<?php
    $mysqli = new mysqli('data', 'tpuser', 'tppass', 'tp3');

    if ($mysqli->connect_errno) {
        printf("Échec de la connexion : %s\n", $mysqli->connect_error);
        exit();
    }

    if ($mysqli->query("INSERT INTO matable (compteur) VALUES (1)")) {
        printf("Count updated<br />");
    } else {
        printf("Erreur lors de l'insertion : %s<br />", $mysqli->error);
    }

    if ($result = $mysqli->query("SELECT * FROM matable")) {
        printf("Count : %d<br />", $result->num_rows);
        $result->close();
    }

    $mysqli->close();
?>
