import json


# This is the Lambda function code for the Afam Financial project.
def lambda_handler(event, context):
    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Afam Financial Lambda!')
    }
