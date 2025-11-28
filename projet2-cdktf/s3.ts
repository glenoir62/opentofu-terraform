import { Construct } from "constructs";
import { App, TerraformStack, TerraformOutput } from "cdktf";
import { AwsProvider } from "@cdktf/provider-aws/lib/provider";
import { S3Bucket } from "@cdktf/provider-aws/lib/s3-bucket";
import { S3BucketPublicAccessBlock } from "@cdktf/provider-aws/lib/s3-bucket-public-access-block";

class MyDemoStack extends TerraformStack {
    constructor(scope: Construct, id: string) {
        super(scope, id);

        // Définir le provider AWS
        new AwsProvider(this, "MonProviderAWS", {
            region: "eu-west-3",
            profile: "projet1-sso",
        });

        // Créer un bucket S3
        const dataBucket = new S3Bucket(this, "MonBucketDeDonnees", {
            // 'this' est le scope, "MonBucketDeDonnees" est l'ID du construct bucket
            bucket: `mon-projet1-cdktf-data-bucket-unique-${this.node.addr.substring(
                this.node.addr.length - 8
            )}`, // Nom de bucket dynamiquement unique
            tags: {
                Name: "BucketDeDonnees-Projet1-CDKTF",
                Environment: "Development", // Peut être dynamisé plus tard
            },
            // Configurations additionnelles pour le bucket
            versioning: {
                enabled: true,
            },
            serverSideEncryptionConfiguration: {
                rule: {
                    applyServerSideEncryptionByDefault: {
                        sseAlgorithm: "AES256",
                    },
                },
            },
            lifecycleRule: [
                {
                    id: "ExpireOldVersions",
                    enabled: true,
                    noncurrentVersionExpiration: {
                        days: 30, // Supprimer les anciennes versions après 30 jours
                    },
                },
                {
                    id: "ExpireOldObjects",
                    enabled: true,
                    expiration: {
                        days: 365, // Supprimer les objets après 365 jours
                    },
                },
            ],
        });

        new S3BucketPublicAccessBlock(this, "MonBucketPublicAccessBlock", {
            bucket: dataBucket.bucket,
            blockPublicAcls: true,
            blockPublicPolicy: true,
            ignorePublicAcls: true,
            restrictPublicBuckets: true,
        });

        // Créer un output pour le nom du bucket
        new TerraformOutput(this, "nom_bucket_data", {
            value: dataBucket.bucket,
        });
    }
}

const app = new App();
new MyDemoStack(app, "projet2-cdktf"); // Nom de la stack qui apparaîtra dans cdktf.out

// Synthétiser la configuration Terraform JSON
app.synth();