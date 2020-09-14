# cython: language_level=3
#  Drakkar-Software OctoBot-Trading
#  Copyright (c) Drakkar-Software, All rights reserved.
#
#  This library is free software; you can redistribute it and/or
#  modify it under the terms of the GNU Lesser General Public
#  License as published by the Free Software Foundation; either
#  version 3.0 of the License, or (at your option) any later version.
#
#  This library is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#  Lesser General License for more details.
#
#  You should have received a copy of the GNU Lesser General Public
#  License along with this library.


""" Order class will represent an open order in the specified exchange
In simulation it will also define rules to be filled / canceled
It is also use to store creation & fill values of the order """
from octobot_trading.portfolios.portfolio cimport Portfolio
from octobot_trading.portfolios.portfolio_manager cimport PortfolioManager

cdef class PortfolioValueManager:
    cdef object logger
    cdef object config

    cdef public double portfolio_origin_value
    cdef public double portfolio_current_value

    cdef public dict currencies_last_prices
    cdef public dict origin_crypto_currencies_values
    cdef public dict current_crypto_currencies_values

    cdef public Portfolio origin_portfolio

    cdef set initializing_symbol_prices
    cdef set missing_currency_data_in_exchange

    cdef PortfolioManager portfolio_manager

    cpdef bint update_origin_crypto_currencies_values(self, str symbol, double mark_price)
    cpdef dict get_current_crypto_currencies_values(self)
    cpdef dict get_current_holdings_values(self)
    cpdef double get_currency_holding_ratio(self, str currency)
    cpdef double get_origin_portfolio_current_value(self, bint refresh_values=*)

    cdef double _update_portfolio_current_value(self, dict portfolio, dict currencies_values=*, bint fill_currencies_values=*)
    cdef void _fill_currencies_values(self, dict currencies_values)
    cdef dict _update_portfolio_and_currencies_current_value(self)
    cdef double _evaluate_value(self, str currency, double quantity, bint raise_error=*)
    cdef double _check_currency_initialization(self, str currency, double currency_value)
    cdef void _recompute_origin_portfolio_initial_value(self)
    cdef double _try_get_value_of_currency(self, str currency, double quantity, bint raise_error)
    cdef void _try_to_ask_ticker_missing_symbol_data(self, str currency, str symbol, str reversed_symbol)
    cdef void _ask_ticker_data_for_currency(self, list symbols_to_add)
    cdef void _inform_no_matching_symbol(self, str currency)
    cdef _evaluate_config_crypto_currencies_and_portfolio_values(self,
                                                                dict portfolio,
                                                                bint ignore_missing_currency_data=*)
    cdef void _evaluate_config_currencies_values(self,
                                                 dict evaluated_pair_values,
                                                 set evaluated_currencies,
                                                 set missing_tickers)
    cdef void _evaluate_portfolio_currencies_values(self,
                                                    dict portfolio,
                                                    dict evaluated_pair_values,
                                                    set valuated_currencies,
                                                    set missing_tickers,
                                                    bint ignore_missing_currency_data)
    cdef double _evaluate_portfolio_value(self, dict portfolio, dict currencies_values=*)
    cdef double _evaluate_portfolio_value(self, dict portfolio, dict currencies_values=*)
    cdef double _get_currency_value(self, dict portfolio, str currency, dict currencies_values=*, bint raise_error=*)
    cdef bint _should_currency_be_considered(self, str currency, dict portfolio, bint ignore_missing_currency_data)
