name: PostgreSQL Workflow

on:
  push:
    branches:
      - main

jobs:
  build:
    runs-on: ubuntu-latest

    services:
      postgres:
        image: postgres:latest
        env:
          POSTGRES_DB: hw_foo
          POSTGRES_USER: hw_foo_user
          POSTGRES_PASSWORD: hw_foo_123
        ports:
          - 5432:5432
        options: --health-cmd pg_isready --health-interval 10s --health-timeout 5s --health-retries 5

    steps:
      - name: Checkout code
        uses: actions/checkout@v2

      - name: Install PostgreSQL Client
        run: |
          sudo apt-get -yqq install postgresql-client

      - name: Run SQL Script
        run: |
          psql -h localhost -U hw_foo_user -d hw_foo_123 -f sql/test.sql
