-- =====================================================
-- DDL Final Sugerido: Plataforma Leitícia (MySQL 5.7+)
-- UUIDs em CHAR(36) para todas as PKs
-- InnoDB, utf8mb4
-- =====================================================

CREATE DATABASE IF NOT EXISTS `plataforma_leiticia`
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;
USE `plataforma_leiticia`;

-- 1) TABELA CENTRAL DE USUÁRIOS
CREATE TABLE `users` (
  `id`                  CHAR(36)       NOT NULL PRIMARY KEY,    -- UUID v4
  `nome`                VARCHAR(255)   NOT NULL,
  `email`               VARCHAR(255)   NOT NULL UNIQUE,
  `celular`             VARCHAR(20),
  `senha_hash`          VARCHAR(255),
  `google_id`           VARCHAR(100)   UNIQUE,
  `tipo_usuario`        ENUM('doadora','receptora','profissional','gestor','admin')
                                                    NOT NULL,
  `data_nascimento`     DATE,
  `cidade`              VARCHAR(100),
  `bairro`              VARCHAR(100),
  `genero`              VARCHAR(30),
  `identidade_genero`   VARCHAR(30),
  `raca_cor`            VARCHAR(30),
  `escolaridade`        VARCHAR(50),
  `situacao_profissional` VARCHAR(50),
  `renda_familiar`      VARCHAR(30),
  `relacao_banco_leite` VARCHAR(50),
  `aceitou_lgpd`        TINYINT(1)     NOT NULL DEFAULT 0,
  `consentimento_dt`    DATETIME,
  `status`              ENUM('ativo','inativo','aguardando_validacao')
                                                    NOT NULL DEFAULT 'ativo',
  `data_criacao`        DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `data_atualizacao`    DATETIME       NOT NULL
                                  DEFAULT CURRENT_TIMESTAMP
                                  ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 2) BANCOS DE LEITE
CREATE TABLE `bancos_leite` (
  `id`                  CHAR(36)       NOT NULL PRIMARY KEY,
  `nome`                VARCHAR(255)   NOT NULL,
  `endereco`            VARCHAR(255)   NOT NULL,
  `bairro`              VARCHAR(100),
  `cidade`              VARCHAR(100),
  `uf`                  CHAR(2),
  `latitude`            DECIMAL(10,7),
  `longitude`           DECIMAL(10,7),
  `telefone`            VARCHAR(30),
  `email`               VARCHAR(255),
  `responsavel`         VARCHAR(100),
  `tipo_unidade`        VARCHAR(50),
  `data_cadastro`       DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 3) DOAÇÕES
CREATE TABLE `doacoes` (
  `id`                  CHAR(36)       NOT NULL PRIMARY KEY,
  `doadora_id`          CHAR(36)       NOT NULL,
  `banco_leite_id`      CHAR(36)       NOT NULL,
  `data_doacao`         DATETIME       NOT NULL,
  `quantidade_ml`       DECIMAL(8,2),
  `status`              ENUM('pendente','agendada','coletada','cancelada','finalizada')
                                                    NOT NULL DEFAULT 'pendente',
  `volume_estimado`     DECIMAL(8,2),
  `data_agendamento`    DATETIME,
  `endereco_coleta`     VARCHAR(255),
  `observacoes`         TEXT,
  `data_criacao`        DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `data_atualizacao`    DATETIME       NOT NULL
                                  DEFAULT CURRENT_TIMESTAMP
                                  ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`doadora_id`)     REFERENCES `users`(`id`),
  FOREIGN KEY (`banco_leite_id`) REFERENCES `bancos_leite`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 4) RECEPÇÕES DE LEITE
CREATE TABLE `recepcoes` (
  `id`                  CHAR(36)       NOT NULL PRIMARY KEY,
  `receptora_id`        CHAR(36)       NOT NULL,
  `banco_leite_id`      CHAR(36)       NOT NULL,
  `data_recepcao`       DATETIME       NOT NULL,
  `quantidade_ml`       DECIMAL(8,2),
  `status`              ENUM('solicitado','em_andamento','recebido','cancelado')
                                                    NOT NULL DEFAULT 'solicitado',
  `indicacao_origem`    VARCHAR(100),
  `observacoes`         TEXT,
  `data_criacao`        DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`receptora_id`)    REFERENCES `users`(`id`),
  FOREIGN KEY (`banco_leite_id`)  REFERENCES `bancos_leite`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 5) HISTÓRICO DE GESTAÇÃO (DOADORAS)
CREATE TABLE `doadora_hist_gestacao` (
  `id`                  CHAR(36)       NOT NULL PRIMARY KEY,
  `doadora_id`          CHAR(36)       NOT NULL,
  `num_filhos`          INT,
  `ordem_gestacao`      INT,
  `idade_primeira_doacao` INT,
  `tipo_concepcao`      VARCHAR(100),
  `data_criacao`        DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`doadora_id`)      REFERENCES `users`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 6) FEEDBACK DAS DOADORAS
CREATE TABLE `doadora_feedback` (
  `id`                  CHAR(36)       NOT NULL PRIMARY KEY,
  `doadora_id`          CHAR(36)       NOT NULL,
  `experiencia`         VARCHAR(100),
  `dificuldades`        TEXT,
  `sugestoes`           TEXT,
  `obstaculos`          TEXT,
  `tipo_apoio`          VARCHAR(100),
  `sistema_reconhecimento` ENUM('sim','nao','indiferente'),
  `notificacoes`        ENUM('sim','nao','indiferente'),
  `data_feedback`       DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`doadora_id`)      REFERENCES `users`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 7) PROFISSIONAIS DE SAÚDE
CREATE TABLE `profissionais` (
  `id`                  CHAR(36)       NOT NULL PRIMARY KEY,
  `user_id`             CHAR(36)       NOT NULL,
  `funcao`              VARCHAR(100),
  `unidade`             VARCHAR(255),
  `conselho`            VARCHAR(50),
  `numero_conselho`     VARCHAR(50),
  `data_cadastro`       DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`user_id`)         REFERENCES `users`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 8) GESTORES / COORDENADORES
CREATE TABLE `gestores` (
  `id`                  CHAR(36)       NOT NULL PRIMARY KEY,
  `user_id`             CHAR(36)       NOT NULL,
  `orgao`               VARCHAR(255),
  `funcao`              VARCHAR(100),
  `data_cadastro`       DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`user_id`)         REFERENCES `users`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 9) CONSENTIMENTOS (LGPD)
CREATE TABLE `consentimentos` (
  `id`                  CHAR(36)       NOT NULL PRIMARY KEY,
  `user_id`             CHAR(36)       NOT NULL,
  `tipo_consentimento`  VARCHAR(100),
  `texto_consentimento` TEXT,
  `data_consentimento`  DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `revogado`            TINYINT(1)     NOT NULL DEFAULT 0,
  `data_revogacao`      DATETIME,
  FOREIGN KEY (`user_id`)         REFERENCES `users`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 10) FORMULÁRIOS E RESPOSTAS
CREATE TABLE `formularios` (
  `id`                  CHAR(36)       NOT NULL PRIMARY KEY,
  `nome`                VARCHAR(100)   NOT NULL,
  `descricao`           TEXT,
  `publico_alvo`        VARCHAR(50),
  `data_criacao`        DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `formulario_respostas` (
  `id`                  CHAR(36)       NOT NULL PRIMARY KEY,
  `formulario_id`       CHAR(36)       NOT NULL,
  `user_id`             CHAR(36)       NOT NULL,
  `respostas`           JSON,
  `data_envio`          DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`formulario_id`)   REFERENCES `formularios`(`id`),
  FOREIGN KEY (`user_id`)         REFERENCES `users`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 11) LOGS DE SISTEMA / AUDITORIA
CREATE TABLE `logs` (
  `id`                  CHAR(36)       NOT NULL PRIMARY KEY,
  `user_id`             CHAR(36),
  `acao`                VARCHAR(255)   NOT NULL,
  `detalhes`            TEXT,
  `ip`                  VARCHAR(45),
  `data_hora`           DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`user_id`)         REFERENCES `users`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 12) NOTIFICAÇÕES
CREATE TABLE `notificacoes` (
  `id`                  CHAR(36)       NOT NULL PRIMARY KEY,
  `user_id`             CHAR(36)       NOT NULL,
  `tipo`                VARCHAR(100)   NOT NULL,
  `mensagem`            TEXT           NOT NULL,
  `is_read`             TINYINT(1)     NOT NULL DEFAULT 0,
  `data_envio`          DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`user_id`)         REFERENCES `users`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
