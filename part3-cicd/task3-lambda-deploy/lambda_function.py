"""
Lambda function module for Afam Financial.
"""

import json


def lambda_handler(event, context):
    """
    AWS Lambda entry point.

    Parameters:
    - event: dict, AWS Lambda uses this parameter to pass in event data.
    - context: object, AWS Lambda uses this parameter to provide runtime information.

    Returns:
    - dict: response with HTTP status and body
    """
    return {
        'statusCode': 200,
        'body': json.dumps(
            'Hello from Afam Financial Lambda!'
        )
    }
