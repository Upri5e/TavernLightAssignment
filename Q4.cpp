//Q4 - Assume all method calls work fine. Fix the memory leak issue in below method
void Game::addItemToPlayer(const std::string& recipient, uint16_t itemId)
{
    Player* player = g_game.getPlayerByName(recipient);
    if (!player) {
        player = new Player(nullptr);
        if (!IOLoginData::loadPlayerByName(player, recipient)) {
            return;
        }
    }

    Item* item = Item::CreateItem(itemId);
    if (!item) {
    return;
    }

    g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);

    if (player->isOffline()) {
    IOLoginData::savePlayer(player);
    }
}

//A4 - Whenver we declare a new object we have to delete it before exiting the function
        //In this code we only create a new player if player does not exist
void Game::addItemToPlayer(const std::string& recipient, uint16_t itemId)
{
	Player* player = g_game.getPlayerByName(recipient);
	bool isNewPlayer = false; //Create a local bool that will tell us if player didnt exist
	if (!player) {
		player = new Player(nullptr);
        isNewPlayer = true; //Set isNewPlayer to true after creating new player object
		if (!IOLoginData::loadPlayerByName(player, recipient)) {
			delete player;  //We delete player before return
			return;
		}
	}

	Item* item = Item::CreateItem(itemId);
	if (!item) {
		if (isNewPlayer)    //If we previously created the player object locally, we delete it before returning
			delete player;
		return; //no point in deleting item since its nullptr
	}

	g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);

	if (player->isOffline()) {
		IOLoginData::savePlayer(player);
	}
	delete item; //We should delete item ptr when we are done with it also when dynamically allocated
	if (isNewPlayer)    //If we previously created the player object locally, we delete it before exiting function
		delete player;
}
