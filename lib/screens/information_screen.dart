import 'package:flutter/material.dart';

class InformationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Grosmetique',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BuildInfoTitle('Utilisation App'),
            BuildInfoDescription(
                'Pour visiter ce site, vous devez avoir au moins 18 ans ou visiter le site sous la surveillance d\'un parent ou d\'un tuteur légal.' +
                    ' Nous vous accordons une licence non transférable ou révocable afin d\'utiliser le site conformément aux termes et conditions spécifiques. Le but de cette licence est de faire des achats d\'articles personnels vendus sur le site. L\'utilisation commerciale ou l\'utilisation au nom de tiers est interdite, sauf autorisation expresse et transparente de notre part. Toute violation de ces termes et conditions entraînera la révocation immédiate de la licence accordée dans ce paragraphe sans aucun préavis.' +
                    'Le contenu affiché sur ce site est fourni à titre informatif uniquement. Les explications des produits exprimées sur ce site appartiennent aux vendeurs eux-mêmes et nous n\'avons rien à voir avec eux. Les commentaires ou opinions exprimés sur ce site sont dus à l\'autorité qui les a publiés et ne reflètent donc pas nos opinions.' +
                    'Certains services et fonctionnalités connexes qui peuvent être disponibles sur le site nécessitent une inscription ou un abonnement. En choisissant de vous inscrire ou de vous abonner à l\'un de ces services ou fonctionnalités connexes, vous acceptez de fournir des informations exactes et à jour sur vous-même et de les mettre à jour en temps opportun en cas de modification. Il est de la responsabilité de chaque utilisateur du site - seul - de conserver les mots de passe et autres méthodes pour déterminer correctement le compte d\'utilisation. L\'entière responsabilité du titulaire du compte incombe à toutes les activités qui se produisent à l\'aide de son mot de passe. De plus, vous devez nous informer de toute utilisation non autorisée de votre mot de passe ou de votre compte. Le site n\'est en aucun cas responsable, directement ou indirectement ou de quelque manière que ce soit, de toute perte ou dommage de quelque nature que ce soit qui pourrait résulter de votre non-respect ou lié à cette section.' +
                    'Lors du processus d\'inscription, le client s\'engage à recevoir des courriels promotionnels du site. Vous pouvez, à une date ultérieure, annuler cette option et ne recevoir aucun e-mail promotionnel en cliquant sur le lien en bas de tout e-mail promotionnel.'),
            BuildInfoTitle('Approuver les demandes et les détails des prix'),
            BuildInfoDescription(
                'Veuillez noter que dans certains cas, une demande peut ne pas être approuvée pour plusieurs raisons. Les opérateurs du site se réservent le droit de rejeter ou d\'annuler toute demande pour quelque raison que ce soit à tout moment. Avant d\'accepter la demande, nous pouvons vous demander de fournir des informations supplémentaires ou d\'autres données pour vérifier quelque chose, y compris - mais sans s\'y limiter, le numéro de téléphone et l\'adresse.' +
                    'Nous nous efforçons de fournir les informations de prix les plus précises à tous les utilisateurs qui visitent le site. Cependant, des erreurs peuvent parfois survenir, comme dans les cas où le prix du produit n\'est pas correctement déterminé sur le site. Par conséquent, nous nous réservons le droit de rejeter ou d\'annuler toute demande. Dans le cas où le prix du produit n\'est pas déterminé correctement, nous avons le droit, à notre seule discrétion, de vous contacter pour obtenir des instructions ou d\'annuler votre commande et de vous informer de cette annulation. Nous avons le droit de refuser ou d\'annuler toute commande, confirmée ou non, après avoir ajouté les frais à la carte de crédit.'),
            BuildInfoTitle('Marques et copyrights'),
            BuildInfoDescription(
                'Tous les droits de propriété intellectuelle, qu\'ils soient enregistrés ou non, sur le site, et toutes les informations et conceptions de contenu sur le site nous appartiennent, y compris, mais sans s\'y limiter, les textes, graphiques, programmes, images, vidéos, musique et son, leur choix et leur coordination, ainsi que Tous les principaux classificateurs de logiciels, codes source et programmes. Tous les contenus du site sont également protégés par des droits d\'auteur combinés sous la forme d\'une seule œuvre. Tous droits réservés.'),
            BuildInfoTitle('La loi en vigueur et les organes judiciaires'),
            BuildInfoDescription(
              'Ces termes et conditions sont interprétés et appliqués conformément aux lois en vigueur dans le pays. En conséquence, chaque partie accepte de comparaître devant les instances judiciaires judiciaires du pays et renonce à toute objection liée au lieu.',
            ),
            BuildInfoTitle('Révoquer le consentement'),
            BuildInfoDescription(
              'En plus de toute disposition légale ou procédure de recours judiciaire, nous pouvons, immédiatement et sans préavis, résilier les présentes conditions générales ou annuler tout ou partie de vos droits accordés en vertu des termes et conditions. Dans tous les cas pour résilier ce contrat, vous devez immédiatement cesser de visiter et d\'utiliser le site, ainsi que d\'émettre des dispositions légales ou des procédures judiciairement équitables, nous pouvons immédiatement annuler tous les mots de passe ou autres méthodes d\'identification de compte qui vous sont accordés, et nous refusons toute visite ou utilisation de ce site entièrement ou Partiellement. Toute révocation de cet accord n\'affectera pas tous les droits et obligations (y compris, mais sans s\'y limiter, les obligations de paiement) des parties émises avant la date de résiliation du contrat. Par conséquent, vous acceptez que le personnel du site n\'assume aucune responsabilité pour vous ou toute autre personne en raison de la suspension ou de la résiliation du service. Si vous n\'êtes pas satisfait de ce site ou de l\'un des termes, conditions, règles, politiques, directives ou pratiques d\'un magasin dans la façon dont le magasin est géré, alors la seule action exclusive que vous devez prendre est alors d\'arrêter d\'utiliser le site.',
            ),
            Container(
              padding: EdgeInsets.only(top: 10.0, bottom: 20.0),
              child: Column(
                children: <Widget>[
                  Text(
                    'Equipe Grosmetique',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    '2021 / 1.0.2',
                    style: TextStyle(
                      fontSize: 7.0,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BuildInfoDescription extends StatelessWidget {
  final String description;
  BuildInfoDescription(this.description);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: Text(
        description,
      ),
    );
  }
}

class BuildInfoTitle extends StatelessWidget {
  final String title;
  BuildInfoTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
