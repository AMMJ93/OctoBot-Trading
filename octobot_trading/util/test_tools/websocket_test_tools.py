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
#  Lesser General Public License for more details.
#
#  You should have received a copy of the GNU Lesser General Public
#  License along with this library

import asyncio

import octobot_commons.channels_name as channels_name
import octobot_commons.tests as commons_tests

import octobot_trading.exchanges as exchanges

try:
    import mock
except ImportError:
    pass

EXPECTED_PUSHED_CHANNELS = {
    channels_name.OctoBotTradingChannelsName.ORDER_BOOK_TICKER_CHANNEL.value,
    channels_name.OctoBotTradingChannelsName.ORDER_BOOK_CHANNEL.value,
    channels_name.OctoBotTradingChannelsName.RECENT_TRADES_CHANNEL.value,
    channels_name.OctoBotTradingChannelsName.MINI_TICKER_CHANNEL.value,
    channels_name.OctoBotTradingChannelsName.OHLCV_CHANNEL.value,
    channels_name.OctoBotTradingChannelsName.KLINE_CHANNEL.value,
    channels_name.OctoBotTradingChannelsName.TICKER_CHANNEL.value
}


async def test_unauthenticated_push_to_channel_coverage_websocket(
        websocket_exchange_class: exchanges.AbstractWebsocketExchange,
        websocket_connector_class: exchanges.AbstractWebsocketConnector,
        exchange_manager: exchanges.ExchangeManager,
        symbols: list,
        time_frames: list,
        expected_pushed_channels: set = None,
        time_before_assert: int = 120):
    pushed_channel_names = set()
    if expected_pushed_channels is None:
        expected_pushed_channels = EXPECTED_PUSHED_CHANNELS

    async def mock_push_to_channel(self, channel_name, **kwargs):
        pushed_channel_names.add(channel_name)

    with mock.patch.object(websocket_connector_class,
                           'push_to_channel',
                           new=mock_push_to_channel):
        ws_exchange = websocket_exchange_class(commons_tests.load_test_config(), exchange_manager)
        with mock.patch.object(websocket_exchange_class,
                               'get_exchange_connector_class',
                               new=mock.Mock()) as get_exchange_connector_class_mock:
            get_exchange_connector_class_mock.return_value = websocket_connector_class
            await ws_exchange.init_websocket(time_frames=time_frames,
                                             trader_pairs=symbols,
                                             tentacles_setup_config=None)
            await ws_exchange.start_sockets()
            await asyncio.sleep(time_before_assert)

    assert pushed_channel_names == expected_pushed_channels

    await ws_exchange.close_sockets()
