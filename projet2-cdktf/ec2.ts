import { Construct } from "constructs";
import { App, TerraformOutput, TerraformStack } from "cdktf";
import { AwsProvider } from "@cdktf/provider-aws/lib/provider";
import { DataAwsAmi } from "@cdktf/provider-aws/lib/data-aws-ami";
import { SecurityGroup } from "@cdktf/provider-aws/lib/security-group";
import { Instance } from "@cdktf/provider-aws/lib/instance";

class MyDemoStack extends TerraformStack {
    constructor(scope: Construct, id: string) {
        super(scope, id);

        // Définir le provider AWS
        new AwsProvider(this, "MonProviderAWS", {
            region: "eu-west-3",
            profile: "projet1-sso",
        });

        const ami = new DataAwsAmi(this, "AmazonLinux2023Ami", {
            mostRecent: true,
            owners: ["amazon"],
            filter: [
                {
                    name: "name",
                    values: ["al2023-ami-*-kernel-*-x86_64"],
                },
                {
                    name: "virtualization-type",
                    values: ["hvm"],
                },
                {
                    name: "architecture",
                    values: ["x86_64"],
                },
            ],
        });

        // Créer un groupe de sécurité
        const webSg = new SecurityGroup(this, "WebServerSG", {
            name: "web-sg-cdktf-projet1",
            description: "Allow HTTP inbound traffic for CDKTF WebServer",
            // vpcId: "vpc-xxxxxxxxxxxxxxxxx", // Important: Les groupes de sécurité nécessitent un VPC.
            // Pour un VPC par défaut, Terraform peut le déduire.
            // Pour un VPC personnalisé, vous devez fournir son ID.
            // Pour cet exemple, nous supposons l'utilisation du VPC par défaut pour la simplicité
            // ou que vous avez défini un vpcId via une variable ou une autre ressource.

            ingress: [
                {
                    description: "HTTP from anywhere",
                    fromPort: 80,
                    toPort: 80,
                    protocol: "tcp",
                    cidrBlocks: ["0.0.0.0/0"],
                    ipv6CidrBlocks: ["::/0"],
                },
            ],
            egress: [
                {
                    description: "Allow all outbound traffic",
                    fromPort: 0,
                    toPort: 0,
                    protocol: "-1", // -1 signifie tous les protocoles
                    cidrBlocks: ["0.0.0.0/0"],
                    ipv6CidrBlocks: ["::/0"],
                },
            ],
            tags: {
                Name: "WebServer-SG-CDKTF-Projet1",
            },
        });

        const instanceType = "t2.micro";
        const environment = "dev-cdktf";
        const instanceName = `web-server-${environment}`;

        const webServer = new Instance(this, "WebServer", {
            ami: ami.id,
            instanceType: instanceType,
            vpcSecurityGroupIds: [webSg.id],
            tags: {
                Name: instanceName,
                Environment: environment,
            },
            maintenanceOptions: {
                autoRecovery: "ENABLED", // Activer la récupération automatique
            },
        });

        // Afficher l'ID de l'instance dans la sortie
        new TerraformOutput(this, "IP publique de l'instance", {
            value: webServer.publicIp,
            description: "L'adresse IP publique de l'instance web server",
        });
    }
}

const app = new App();
new MyDemoStack(app, "projet2-cdktf"); // Nom de la stack qui apparaîtra dans cdktf.out

// Synthétiser la configuration Terraform JSON
app.synth();