FROM python:3.12-alpine
# Create a non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
# Set working directory and user permissions
WORKDIR /app
COPY ./main.py .
RUN chown -R appuser:appgroup /app
# Drop privileges
USER appuser
CMD ["python3", "main.py"]