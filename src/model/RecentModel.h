/*
 * RecentModel.h
 *
 *  Created on: 18/10/2014
 *      Author: laairoy
 */

#ifndef RECENTMODEL_H_
#define RECENTMODEL_H_

#include <bb/cascades/GroupDataModel>

class RecentModel: public bb::cascades::GroupDataModel {
public:
    RecentModel();
    virtual ~RecentModel();
    void addRecent(QString name, QString value, QString type, QString sender, qint64 size);
};

#endif /* RECENTMODEL_H_ */
