"""
Lambda function module for Afam Financial.
"""

import json


def lambda_handler(event, context): # pylint: disable=unused-argument
    """
    AWS Lambda entry point.

    Parameters:
    - event
    - context
    """
    return {
        'statusCode': 200,
        'body': json.dumps(
            'Hello from Afam Financial Lambda!'
        )
    }
