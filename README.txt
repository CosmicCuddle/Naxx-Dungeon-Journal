Dungeon Journal - v0.2.1 TEST
===================================

A WoW 3.3.5a-compatible server Dungeon Journal inspired closely by the layout and interaction style of Forever Dungeon Journal.

THIS IS A SECOND VISUAL / DATA TEST BUILD.

Major v0.2 changes
- Five dungeon tabs: Trash, Bosses, Quests, Preparation and Map.
- Correct 3.3.5 client loading-screen artwork paths for the browser, with a stronger centre crop to remove the Warcraft logo and top/bottom loading-screen framing.
- Corrected Vanilla Stockade, Scarlet Monastery and Stratholme artwork paths.
- Corrected shared TBC artwork paths and 3.3.5 Wrath loading-screen paths.
- Real 3.3.5 creature models are used as selected-boss portraits where a creature ID is available.
- Boss pages now include a concise encounter summary, abilities/phases, key mechanics, a full AtlasLoot-style loot table and drop rates.
- Trash pages list dangerous trash abilities plus dungeon-specific AtlasLoot-style trash drops and drop rates.
- Dungeon maps use the 3.3.5 client's own WorldMap dungeon tiles. Multi-floor dungeons receive Previous / Next floor controls.
- Jintha'Alor uses the Hinterlands zone map because it is outdoor dungeon-style content.

Fully upgraded v0.2 example entries
- Ragefire Chasm
- The Deadmines
- Wailing Caverns
- Jintha'Alor

The remaining dungeon covers and many Vanilla map definitions are already wired in, but their full trash/boss/quest databases will be populated after this interface is approved.

Important loot note
The journal follows the AtlasLoot approach: boss tables contain the encounter-specific drops and the Trash tab contains dungeon-specific trash drops. Generic cloth, coin, food, vendor junk and broad random world-green pools are not mislabelled as dungeon-specific loot. Jintha'Alor is outdoor content, so broad zone/world drops are treated separately from its quest-critical encounter drops.

Commands
/dj
/dungeonjournal

Install
1. Close World of Warcraft.
2. Back up or remove the previous DungeonJournal folder.
3. Extract the fresh DungeonJournal folder into Interface\AddOns.
4. Start WoW and enable Dungeon Journal.
5. Type /dj.

Do not copy v0.2 over an older test folder. Replace the folder so stale files cannot survive between builds.
