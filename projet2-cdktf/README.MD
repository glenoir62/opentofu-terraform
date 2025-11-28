# Infrastructure as Code avec CDKTF

Gestion de l'infrastructure cloud avec Cloud Development Kit for Terraform (CDKTF) en TypeScript.

## Prérequis

- [Node.js](https://nodejs.org/) >= 18.x
- [Terraform](https://www.terraform.io/downloads) >= 1.0
- [CDKTF CLI](https://developer.hashicorp.com/terraform/cdktf/cli-reference/cli-configuration) >= 0.20
```bash
npm install -g cdktf-cli@latest
```

## Installation
```bash
# Cloner le projet
git clone <repository-url>
cd <project-name>

# Installer les dépendances
npm install
```

## Structure du projet
```
.
├── main.ts                 # Point d'entrée, définition des stacks
├── cdktf.json             # Configuration CDKTF
├── tsconfig.json          # Configuration TypeScript
├── package.json           
├── cdktf.out/             # Fichiers Terraform générés (gitignored)
└── terraform.tfstate      # State Terraform (gitignored)
```

## Commandes

### Développement
```bash
# Compiler le TypeScript
npm run build

# Watch mode (recompilation auto)
npm run watch

# Générer les fichiers Terraform JSON
cdktf synth
```

### Déploiement
```bash
# Voir le plan d'exécution
cdktf diff

# Déployer l'infrastructure
cdktf deploy

# Déployer sans confirmation interactive
cdktf deploy --auto-approve

# Détruire l'infrastructure
cdktf destroy
```

### Tests
```bash
# Lancer les tests unitaires
npm test

# Tests avec coverage
npm run test:coverage
```

## Configuration

### Providers

Les providers sont configurés dans `main.ts`. Exemple :
```typescript
import { App, TerraformStack } from "cdktf";
import { AwsProvider } from "@cdktf/provider-aws/lib/provider";

class MyStack extends TerraformStack {
  constructor(scope: Construct, id: string) {
    super(scope, id);

    new AwsProvider(this, "aws", {
      region: "eu-west-3"
    });
  }
}
```

### Variables d'environnement

Créer un fichier `.env` (non versionné) :
```bash
AWS_ACCESS_KEY_ID=<your-key>
AWS_SECRET_ACCESS_KEY=<your-secret>
AWS_REGION=eu-west-3
```

## Bonnes pratiques

### Organisation des stacks
```typescript
// Séparer les environnements
class DevStack extends TerraformStack { }
class ProdStack extends TerraformStack { }

const app = new App();
new DevStack(app, "dev");
new ProdStack(app, "prod");
app.synth();
```

### Abstractions réutilisables
```typescript
// Créer des constructs personnalisés
class MyS3Bucket extends Construct {
  constructor(scope: Construct, id: string, env: string) {
    super(scope, id);
    
    new S3Bucket(this, "bucket", {
      bucket: `myapp-${env}`,
      versioning: { enabled: env === "prod" }
    });
  }
}
```

### Tests
```typescript
import { Testing } from "cdktf";
import { MyStack } from "../main";

describe("MyStack", () => {
  it("should create an S3 bucket", () => {
    const app = Testing.app();
    const stack = new MyStack(app, "test");
    const synthesized = Testing.synth(stack);
    
    expect(synthesized).toHaveResource("aws_s3_bucket");
  });
});
```

## Migration depuis HCL

Si tu as du code Terraform HCL existant :
```bash
# Convertir du HCL en CDKTF
cdktf convert --language typescript --provider aws
```

## Debugging
```bash
# Mode verbose
CDKTF_LOG_LEVEL=debug cdktf deploy

# Voir les fichiers Terraform générés
cat cdktf.out/stacks/<stack-name>/cdk.tf.json
```

## Ressources

- [Documentation CDKTF](https://developer.hashicorp.com/terraform/cdktf)
- [CDKTF Examples](https://github.com/hashicorp/terraform-cdk/tree/main/examples)
- [Provider AWS](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)

## Licence

MIT