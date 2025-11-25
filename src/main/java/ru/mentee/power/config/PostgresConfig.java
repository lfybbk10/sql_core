/* @MENTEE_POWER (C)2025 */
package ru.mentee.power.config;

import java.util.Properties;

public class PostgresConfig implements DatabaseConfig {

    private Properties properties;

    public PostgresConfig(Properties properties) {
        this.properties = properties;
    }

    @Override
    public String getUrl() {
        return properties.getProperty("db.url");
    }

    @Override
    public String getUsername() {
        return properties.getProperty("db.username");
    }

    @Override
    public String getPassword() {
        return properties.getProperty("db.password");
    }

    @Override
    public String getDriver() {
        return properties.getProperty("db.driver");
    }

    @Override
    public boolean getShowSql() {
        return true;
    }
}
