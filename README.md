# Terraform EC2 Apache Example


![appach](https://github.com/user-attachments/assets/423a37d3-cfe8-4cb4-baa6-c3a1e74ef75b)

Tento projekt ukazuje, jak vytvořit EC2 instanci na AWS s pomocí Terraformu, nainstalovat na ni Apache server a nastavit jednoduchou webovou stránku.

## Požadavky
- Terraform nainstalovaný na lokálním počítači.<br>
  https://developer.hashicorp.com/terraform/install?product_intent=terraform  

- AWS účet s přístupovými oprávněními.

## Krok za krokem
1. Zkopírujte soubor `main.tf`.
2. Spusťte příkazy:
   ```
   terraform init
   terraform plan 
   terraform apply
   ```
   a... kdyz vas to nebai ... tak...
 ```
   terraform destroy
```

## Struktura projektu 
 ```

├── main.tf                # Terraform kód pro vytvoření infrastruktury
├── README.md              # Popis projektu
