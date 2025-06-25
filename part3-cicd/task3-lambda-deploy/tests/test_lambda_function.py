"""
Unit test for the Afam Financial Lambda function.
"""

import json
import pytest
from lambda_function import lambda_handler


def test_lambda_handler_returns_expected_response():
    """
    Test that the lambda_handler returns the correct response structure.
    """
    event = {}
    context = {}
    response = lambda_handler(event, context)

    assert isinstance(response, dict)
    assert response.get('statusCode') == 200

    body = json.loads(response.get('body', ''))
    assert body == 'Hello from Afam Financial Lambda!'
