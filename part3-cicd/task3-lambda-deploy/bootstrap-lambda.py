def lambda_handler(event, context):
    return {
        'statusCode': 200,
        'body': 'Bootstrap Lambda deployed via Terraform is running successfully.'
    }

