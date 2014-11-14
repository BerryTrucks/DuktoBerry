/*
 * BuddyModel.h
 *
 *  Created on: 03/04/2014
 *      Author: laairoy
 */

#ifndef BUDDYMODEL_H_
#define BUDDYMODEL_H_

#include <bb/cascades/GroupDataModel>
#include "protocol/peer.h"

class Peer;
class QUrl;

class BuddyModel: public bb::cascades::GroupDataModel {
public:
	BuddyModel();
	virtual ~BuddyModel();
	void addMeElement();
	void addIpElement();
	void addBuddy(QString ip, qint16 port, QString username, QString system,
			QString platform, QUrl avatarPath);
	void addBuddy(Peer& peer);
	void removeBuddy(QString ip);
	void showSingleBack(int idx);
	void updateMeElement();
	int count();
	QString buddyNameByIp(QString ip);
//	QStandardItem* buddyByIp(QString ip);

private:
	QVariantMap mItemsMap;
	QVariantMap mMeItem;
};

#endif /* BUDDYMODEL_H_ */
