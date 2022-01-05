--
-- PostgreSQL database dump
--

-- Dumped from database version 13.4
-- Dumped by pg_dump version 13.5

-- Started on 2022-01-05 21:41:17 UTC

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 12 (class 2615 OID 16764)
-- Name: twitter; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA twitter;


SET default_table_access_method = heap;

--
-- TOC entry 230 (class 1259 OID 45836)
-- Name: favorite_tweets; Type: TABLE; Schema: twitter; Owner: -
--

CREATE TABLE twitter.favorite_tweets (
    id bigint NOT NULL,
    created_at timestamp with time zone NOT NULL,
    "user" text NOT NULL,
    name text NOT NULL,
    text text NOT NULL
);


--
-- TOC entry 2931 (class 2606 OID 45843)
-- Name: favorite_tweets favorite_tweets_pkey; Type: CONSTRAINT; Schema: twitter; Owner: -
--

ALTER TABLE ONLY twitter.favorite_tweets
    ADD CONSTRAINT favorite_tweets_pkey PRIMARY KEY (id, created_at);


-- Completed on 2022-01-05 21:41:17 UTC

--
-- PostgreSQL database dump complete
--

