/* @MENTEE_POWER (C)2025 */
package ru.mentee.power.config;

import java.util.*;
import lombok.extern.slf4j.Slf4j;
import ru.mentee.power.exception.SASTException;

@Slf4j
public class SecureValidator {
    // Список слабых паролей
    private static final Set<String> WEAK_PASSWORDS = Set.of("password", "123456", "admin");

    // Ключевые слова, по которым считаем, что property потенциально хранит пароль/секрет
    private static final List<String> SENSITIVE_KEYS =
            List.of("password", "pwd", "pass", "secret", "token", "apikey", "api_key");

    private Properties properties;

    public SecureValidator(Properties properties) {
        this.properties = properties;
    }

    /**
     * Проверяет .properties файл на отсутствие паролей и слабых паролей.
     * В случае обнаружения уязвимости:
     *  - логирует нарушение
     *  - выбрасывает SASTException
     *
     * @throws SASTException при обнаружении уязвимостей
     */
    public void validate() throws SASTException {
        if (properties == null) {
            throw new IllegalArgumentException("Файл properties не найден или путь не указан ");
        }

        List<String> violations = new ArrayList<>();

        for (String name : properties.stringPropertyNames()) {
            String value = properties.getProperty(name);

            // Проверка подозрительных ключей: если ключ содержит "password" или другие маркеры
            if (isSensitiveKey(name) && value != null && !value.isBlank()) {
                String msg =
                        String.format(
                                "Обнаружен возможный пароль/секрет в properties файле. Ключ: '%s',"
                                        + " файл: '%s'",
                                name);
                violations.add(msg);
                log.error(msg);
            }

            // Проверка на слабые пароли по значению
            if (isWeakPassword(value)) {
                String msg =
                        String.format(
                                "Обнаружен слабый пароль в properties файле. Ключ: '%s', значение:"
                                        + " '%s'",
                                name, value);
                violations.add(msg);
                log.error(msg);
            }
        }

        if (!violations.isEmpty()) {
            StringBuilder sb =
                    new StringBuilder("Обнаружены уязвимости в файле properties").append(":\n");
            for (String v : violations) {
                sb.append(" - ").append(v).append('\n');
            }
            throw new SASTException(sb.toString());
        }

        log.info("Проверка properties файла завершена, уязвимостей не найдено");
    }

    /**
     * Проверяет, является ли значение слабым паролем.
     */
    private boolean isWeakPassword(String value) {
        if (value == null) {
            return false;
        }
        String normalized = value.trim().toLowerCase(Locale.ROOT);
        return WEAK_PASSWORDS.contains(normalized);
    }

    /**
     * Проверяет, является ли имя ключа "чувствительным"
     * (т.е. с большой вероятностью хранит пароль/секрет).
     */
    private boolean isSensitiveKey(String key) {
        if (key == null) {
            return false;
        }
        String normalized = key.toLowerCase(Locale.ROOT);
        for (String marker : SENSITIVE_KEYS) {
            if (normalized.contains(marker)) {
                return true;
            }
        }
        return false;
    }
}
