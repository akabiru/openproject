import { Injectable } from '@angular/core';
import { EffectHandler } from 'core-app/core/state/effects/effect-handler.decorator';
import { ActionsService } from 'core-app/core/state/actions/actions.service';
import { ViewsStore } from 'core-app/core/state/views/views.store';
import { IView } from 'core-app/core/state/views/view.model';
import {
  CollectionStore,
  ResourceCollectionService,
} from 'core-app/core/state/resource-collection.service';
import { InjectField } from 'core-app/shared/helpers/angular/inject-field.decorator';

@EffectHandler
@Injectable()
export class ViewsResourceService extends ResourceCollectionService<IView> {
  @InjectField() actions$:ActionsService;

  protected createStore():CollectionStore<IView> {
    return new ViewsStore();
  }

  protected basePath():string {
    return this
      .apiV3Service
      .views
      .path;
  }
}
