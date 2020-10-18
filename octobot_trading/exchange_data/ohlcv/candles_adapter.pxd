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
cimport numpy as np
np.import_array()


cpdef np.ndarray get_symbol_close_candles( symbol_data, str time_frame,  int limit, bint include_in_construction) # TODO : fix cimport exchange_symbol_data.ExchangeSymbolData
cpdef np.ndarray get_symbol_open_candles(object symbol_data, str time_frame, int limit, bint include_in_construction)  # TODO : fix cimport exchange_symbol_data.ExchangeSymbolData
cpdef np.ndarray get_symbol_high_candles(object symbol_data, str time_frame, int limit, bint include_in_construction)  # TODO : fix cimport exchange_symbol_data.ExchangeSymbolData
cpdef np.ndarray get_symbol_low_candles(object symbol_data, str time_frame, int limit, bint include_in_construction)  # TODO : fix cimport exchange_symbol_data.ExchangeSymbolData
cpdef np.ndarray get_symbol_volume_candles(object symbol_data, str time_frame, int limit, bint include_in_construction)  # TODO : fix cimport exchange_symbol_data.ExchangeSymbolData
cpdef np.ndarray get_symbol_time_candles(object symbol_data, str time_frame, int limit, bint include_in_construction)

cdef np.ndarray _add_in_construction_data(np.ndarray candles, object symbol_data, object time_frame, int data_type)  # TODO : fix cimport exchange_symbol_data.ExchangeSymbolData